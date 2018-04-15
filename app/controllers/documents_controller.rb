class DocumentsController < ApplicationController
  # Before doing any of these actions, call these methods first, if anything is in the only
  # array, then only do those actions, otherwise do every action
  # They are used for authentication and security purposes to filter out HTTP requests
  # that people shouldn't be doing
  before_action :set_document, only: [:show, :edit, :update, :destroy]
  before_action :check_user
  before_action :check_document, only: [:show, :edit, :update, :destroy]

  # GET /applications
  # GET /applications.json
  def index
    # Redirect to new_apps if person isn't allowed to see all applications
    if !current_user.supervisor_role && !current_user.readonly_role
      redirect_to applications_new_apps_path
    end
    @users = User.where(supervisor_role: '1')
    if params[:search]
      # If search is present, display those
      @documents = Document.paginate(:page => params[:page], :per_page => 10).search(params[:search]).order("created_at DESC")#.where(:is_archived => '0') #1isArchived
    else
      # display all applications based on when they were created
      @documents = Document.paginate(:page => params[:page], :per_page => 10).all.order("created_at DESC")#.where(:is_archived => '0')
    end
  end

  # GET /applications/new_apps
  def new_apps
    # Kyle: This is the sloppiest thing in this application and you'll see why:
    # In order to get the assignments tab to function properly, I grabbed
    # all the board members, then every assignment
    # the new assignment is incase you want to create a new assignment, I think it works
    # without that line
    # in the HTML I loop through every assignment every row to see if a person is assigned to it
    # I know theres a better way to do this and I might come back to fix it
    @users = User.where(supervisor_role: '1')
    @assignment = Assignment.new
    @a = Assignment.all

  	if current_user.supervisor_role || current_user.readonly_role
      # If person is a board member OR a readonly board member, then display every new document
  	   @documents = Document.where(state: 'new_app').or(Document.where(state: 'needs_revisions').where(is_resubmitted: '1')).order("updated_at DESC").paginate(:page => params[:page], :per_page => 10)
  	else
      # otherwise, get all the documents that the user has submitted
  	   @documents = Document.paginate(:page => params[:page], :per_page => 10).where(state: 'new_app').where(:user_id => current_user.id).order("updated_at DESC")
	  end
  end
  # GET /applications/approved
  def approved
    # Kyle: To be honest, this route and action name needs to be changed or something
  	if current_user.supervisor_role || current_user.readonly_role
      # If person is a board member OR a readonly board member, then display every document
      # I dont think this is even used anymore.  It was in earlier stages of the application
  	   @documents = Document.paginate(:page => params[:page], :per_page => 10).where(state: 'approved').order("created_at DESC")
  	else
      # This part of the block is used though.  This will display the current user's approved applications
  	   @documents = Document.paginate(:page => params[:page], :per_page => 10).where(state: 'approved').where(:user_id => current_user.id).order("created_at DESC")
 	  end
  end
  # GET /applications/assignments
  def assignments
    # Kyle: I'm really not sure why this exists?  We use POST applications/assignments but not GET.
    # So this block of code is not used
    # I think originally we were going to use this as a way to list out assignments
    if !current_user.supervisor_role
      redirect_to applications_new_apps_path
    end
    @assignments = Assignment.where(user_id: current_user.id)
    @array = Array.new
    @assignments.each do |a|

      @array.push(a.document_id)

    end


    @documents = Document.paginate(:page => params[:page], :per_page => 10).where(id: @array, state: 'new_app').order("created_at DESC")
  end

  # GET /applications/rejected
  def archived
    if current_user.supervisor_role || current_user.readonly_role
      # If person is a board member OR a readonly board member, then display every archived document
  	   @documents = Document.paginate(:page => params[:page], :per_page => 10).where(is_archived: 'yes').order("created_at DESC")
  	else
      # Display current users archived applications
    	@documents = Document.paginate(:page => params[:page], :per_page => 10).where(is_archived: 'yes').where(:user_id => current_user.id).order("created_at DESC")
  	end
  end

  # GET /applications/1
  # GET /applications/1.json
  def show
    # When you view an application, it comes to this action
    # First, grab the current user
    # Kyle: creating these new objects seems like wasted memory if you're not a board member
    # BUT i think they get deleted after you leave the page anyways?
    # Might wanna add in an if statement later
    @user = current_user
    # Create a new comment
    @comment = Comment.new
    # Create a new chair comment
    @chair_comment = ChairComment.new
    # Grab the last chair comment to display to everyone
    @last_comment = ChairComment.where(document_id: @document.id).last
    # When creating a comment, make sure its foreign keys are associated
    # to the current document and current user
    @comment.document_id = @document.id
    @comment.user_id = @user.id
    # Another subquery.  First query is the Assignment query that grabs all the assignments associated
    # with this current document, then 'pluck' the user ids of them and put those user ids into an array of integers
    # Then with those arrays of integers, find those users and put them into an @assignments array of Users
    # to be looped through in the HTML
    @assignments = User.where(id: Assignment.where(document_id: @document.id).pluck('user_id'))

    # Get all the votes for this document to display back to the board
    @votes = Vote.where(document_id: @document.id)
    # grab your vote
    @your_votes = Vote.where(document_id: @document.id, user_id: @user.id)
    # Grab all the comments associated with this document and paginate them so there's not 8 billion of them
    @comments = Comment.paginate(:page => params[:page], :per_page => 5).where(document_id: @document.id)
  end

  # GET /applications/new
  def new
    # Grab the current user
    @user = current_user
    # Create a new document associated with the user using rails built in
    # relationships.  For more information look at http://guides.rubyonrails.org/association_basics.html
    @document = @user.documents.new
  end

  # GET /applications/1/edit
  def edit
    # This action needs to be here to render the page, but really doesn't do much else

  end

  # POST /applications
  # POST /applications.json
  def create
    @user = current_user
    @test = Assignment.all
    # create a new document associated with the user and only whitelisted params.
    # This is probably the most dangerous part of the app security wise because anyone can get here
    # so we need to make sure the only things that get passed into the application are things we allow
    @document = @user.documents.new(document_params)

    respond_to do |format|
      if @document.save
        # Email the user and chair that a new application was submitted
        UserEmailMailer.submit_document(@document.email).deliver
        UserEmailMailer.new_app(@document).deliver
        # Create empty votes for every board member
        @array = Array.new
        @board = User.where(supervisor_role: true)
        @board.each do |b|
          # by setting everyone's vote to 'new_app', we don't have to add
          # a new state to the model file and can assume that any vote for
          # new app is actually just empty and not a real vote
          @current_user = User.find(b.id)
          @empty_vote = @document.votes.new
          @empty_vote.state = 'new_app'
          # associate the empty vote with the current user, I think I tried
          # to use regular associations but it wasn't having it
          @empty_vote.user_id = @current_user.id
          @empty_vote.save
        end
        format.html { redirect_to @document, notice: 'Document was successfully created.' }
        format.json { render :show, status: :created, location: @document }
      else
        format.html { render :new }
        format.json { render json: @document.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /applications/1
  # PATCH/PUT /applications/1.json
  def update
    respond_to do |format|

		# @oldstate = @document.state

		if @document.update(document_params)
    		# @newstate = @document.state
        # @document.is_resubmitted = true
        # The above two lines were commented out because I believe this line is a better way of doing things
        # We added in a is_resubmitted boolean to check if an application has been updated by the investigator
        # and if it has ,then we email the chair
        @document.update_attributes(is_resubmitted: true)
        UserEmailMailer.resubmit(@document).deliver
        format.html { redirect_to @document, notice: 'Document was successfully updated.' }
        format.json { render :show, status: :ok, location: @document }
      else
        format.html { render :edit }
        format.json { render json: @document.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /applications/1
  # DELETE /applications/1.json
  def destroy
    # KILL THE APPLICATION
    @document.destroy
    respond_to do |format|
      format.html { redirect_to documents_url, notice: 'Document was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def check_user
      # Check if user is signed in
      if (!user_signed_in?)
        redirect_to root_path, notice: 'You must log in to do that'
      end
    end
    def check_document
      # Only allow board members, read only board members, and the investigator view an application
      # Boolean logic is hard
      if (@document.user_id != current_user.id && !current_user.supervisor_role && !current_user.readonly_role)
        redirect_to root_path, notice: 'You can only view your own applications'
      end
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_document
      @document = Document.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def document_params
      params.require(:document).permit(:fName, :lName, :phone, :email, :address,
         :department, :typeOfApplication, :project_title, :sponsor_name, :start_date,
         :end_date, :research_question, :lit_review, :procedure, :pool_of_subjects,
         :sub_recruitment, :risks, :opt_participation, :confidentiality, :authorities_consent,
         :subjects_consent, :parental_consent, :state, :is_archived, :questions_file, :advisor_sig,
       :consent_file, :child_assent_file, :hsr_certificate_file, :written_permission_file, :users_id, :created_at,
     :updated_at)
    end
end
