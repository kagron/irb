class DocumentsController < ApplicationController
  before_action :set_document, only: [:show, :edit, :update, :destroy]
  before_action :check_user


  # GET /applications
  # GET /applications.json
  def index
    @users = User.where(supervisor_role: '1')
    if params[:search]
      @documents = Document.search(params[:search]).order("created_at DESC")#.where(:is_archived => '0') #1isArchived
    else
      @documents = Document.all.order("created_at DESC")#.where(:is_archived => '0')
    end
  end

  def new_apps

  @users = User.where(supervisor_role: '1')

	if current_user.supervisor_role
	   @documents = Document.where(state: 'new_app').order("created_at DESC")
	else
	   @documents = Document.where(state: 'new_app').where(:email => current_user.email).order("created_at DESC")


	end
  end

  # GET /applications/approved
  def approved

	if current_user.supervisor_role

	@documents = Document.where(state: 'approved').order("created_at DESC")

	else

	@documents = Document.where(state: 'approved').where(:email => current_user.email).order("created_at DESC")


	end
  end

  # GET /applications/needs_revisions
  def needs_revisions
    @users = User.where(supervisor_role: '1')
    @documents = Document.where(state: 'needs_revisions').order("created_at DESC")
  end

  # GET /applications/rejected
  def assignments
    @users = User.where(supervisor_role: '1')
    @documents = Document.where(state: 'new_app').order("created_at DESC")
  end

  # GET /applications/rejected
  def archived

  if current_user.supervisor_role

	@documents = Document.where(is_archived: 'yes').order("created_at DESC")

	else

	@documents = Document.where(is_archived: 'yes').where(:email => current_user.email).order("created_at DESC")

	end

  end

  # GET /applications/1
  # GET /applications/1.json
  def show
    @user = current_user
    @comment = Comment.new
    @comment.document_id = @document.id
    @comment.user_id = @user.id

    @comments = Comment.where(document_id: @document.id)
  end

  # GET /applications/new
  def new
    @user = current_user
    @document = @user.documents.new
  end

  # GET /applications/1/edit
  def edit
  end

  # POST /applications
  # POST /applications.json
  def create
    @user = current_user
    @document = @user.documents.new(document_params)

    respond_to do |format|
      if @document.save
        UserEmailMailer.submit_document(current_user.email).deliver
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

		@oldstate = @document.state

		if @document.update(document_params)
    		@newstate = @document.state

    		if (@oldstate != @newstate)
      		UserEmailMailer.update_document(current_user.email).deliver
        end
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
    @document.destroy
    respond_to do |format|
      format.html { redirect_to documents_url, notice: 'Document was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def check_user
      if (!user_signed_in?)
        redirect_to root_path, notice: 'You must log in to do that'
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
       :consent_file, :child_assent_file, :hsr_certificate_file, :written_permission, :users_id, :created_at,
     :updated_at)
    end
end
