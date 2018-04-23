class IrbController < ApplicationController
  # before these actions, run these methods
  before_action :check_user, only: [:edit, :update]
  before_action :check_board, only: [:edit, :update]
  before_action :check_chair, only: [:board]

  # GET request to /
  def home
    # Grab the first (and only) front page in the database
    @front_page = Page.first
  end

  # POST request to /
  def create
    # Retrieve post from database
    @front_page = Page.new(home_params)

    # Mass Assign edited post attributes
    if @front_page.save
      flash[:success] = "Home Page updated!"
      # Show success message and redirect to home page
      redirect_to root_path
    else
      # if something failed, return back to the edit page
      render action: :edit
    end
  end

  # GET request to /edit
  def edit
    @front_page = Page.first
    if !@front_page.present?
      # If there is no front page, change the page to the new page instead
      # It will look the same
      @front_page = Page.new
    end
  end

  # PATCH request to /
  def update
    # Retrieve post from database
    @front_page = Page.first

    # Mass Assign edited post attributes
    if @front_page.update_attributes(home_params)
      flash[:success] = "Home Page updated!"
      # Show success message and redirect to home page
      redirect_to root_path
    else
      render action: :edit
    end
  end

  # GET request to /board
  def board
    # If current user is not the chair then they're redirected
    # I'm not sure why this isn't in a private method down below but whatever
    if !current_user.superadmin_role
      redirect_to root_path, notice: "You have to be the chair to do that"

    else
      # Grabs everyone in the board from the database and store them in these
      # instanced variables
      @chair = User.where(superadmin_role: '1')
      @board = User.where(supervisor_role: '1').where(superadmin_role: '0')
      @readonly = User.where(readonly_role: '1')
    end

  end

  # GET request to /search
  # Technically this GET request happens in the background for searching
  def search
      if params[:query]
          # If query is in the params (POST/GET request) array then grab the name
          # Name will be passed as one string so we had to split it to co-operate
          # with our database since first_name and last_name are stored separately
          @name = params[:query].split(" ")
          @new = User.where(first_name: @name[0], last_name: @name[1]).first
          # new is the user that we are going to make a 'new' board member
          if @new.present?
            if params[:readonly]
              # Kyle: I didn't want to create a new action so i passed another value in
              # the POST request for readonly users
              @new.readonly_role = '1'
              @new.save
              redirect_to board_path, notice: "Member succesfully added"

            elsif @new.supervisor_role = '0'
              # If readonly is NOT in the params array, make them a board member
              # you can use true/false here instead of 1's and 0's
              @new.supervisor_role = '1'
              @new.superadmin_role = '0'
              @new.readonly_role = '0'
              @new.save
              redirect_to board_path, notice: "Board member succesfully added"
            else
              redirect_to board_path, notice: @new.first_name + " " + @new.last_name + " is already a board member"
            end
          else
            # if user is not found or nothing was passed, this returns an error
          redirect_to board_path, notice: "User does not exist"
        end
      end
  end

  # DELETE request to users/:id/removeboard
  def removeBoard

    # find the user in the database using the value passed in the params array (GET/POST Data)
    @user = User.find(params[:id])
<<<<<<< HEAD
=======
    #@a = Assignment.where(user_id: @user.id).pluck('document_id')
    # These queries were a pain to figure out but what they are, are subqueries.
    # The first query that will get executed is the first one and return an array of documents
    # associated with the user we are looking for.  Then we pass in that array into assignments and votes
    # to find out which assignments and votes to destroy because this user is no longer a board member
    # NOTE: we only destroyed the ones that are NOT archived because we figured the board
    # would still want to know who reviewed documents in the past.
>>>>>>> 12c3e80af1a4ea65b1008cf66009717cc37ee82f
    @x = Assignment.where(document_id: Document.where(is_archived: 'no'), user_id: @user.id)
    @v = Vote.where(document_id: Document.where(is_archived: 'no'), user_id: @user.id)

    # @x and @v will be arrays, so we need to foreach through them and destroy them all
    # There might be a delete_all method but I'm not sure
    @x.each do |x|
        x.destroy
    end
    @v.each do |v|
      v.destroy
    end

    # After everything is destroyed, change their permissions back to normal user
    @user.superadmin_role = '0'
    @user.supervisor_role = '0'
    @user.readonly_role = '0'
    @user.save
    redirect_to board_path, notice: "Member succesfully removed"

end
  # DELETE request to users/:id/removechair
  def removeChair
    # Find the members who have chair permissions
    @chairMems = User.where(superadmin_role: '1')

    if @chairMems.size > 1
      # We want to make sure there's a backup chair before changing any permissions
      # because they act as admins in this app.  If there is a backup, we get rid of
      # the person selected
      @user = User.find(params[:id])
      @user.supervisor_role = '1'
      @user.superadmin_role = '0'
      @user.save
      redirect_to board_path, notice: "Chair member was succesfully demoted"

    else
      # If there is only one chair, we tell them to name a new chair
      redirect_to board_path, notice: "Please name a new chair first"

    end

  end
  # POST request to users/:id/addchair
  def addChair
    # Find the user specified, and add them as a chair
    # They have to be a board member first with the way we coded it
    @user = User.find(params[:id])
    @user.supervisor_role = '1'
    @user.superadmin_role = '1'
    @user.save
    redirect_to board_path, notice: "Board member was succesfully promoted to chair"

  end



  private
    def check_user
      # redirect if user is not signed in
      if (!user_signed_in?)
        redirect_to root_path, notice: 'You must log in to do that'
      end
    end
    def check_chair
      # redirect if person is not a chair
      if !current_user.superadmin_role
        redirect_to root_path, notice: 'You must be chair to do that'
      end
    end
    def check_board
      # redirect if person is not a board member
      if !current_user.supervisor_role
        redirect_to root_path, notice: 'You don\'t have permissions to do that'
      end
    end
    # strong params
    def home_params
      # whitelist these variables
       params.require(:page).permit(:title, :content)
    end

    def search_params
      # whitelist these variables
        params.require(:user).permit(:first_name, :last_name)
    end

end
