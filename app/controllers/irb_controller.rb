class IrbController < ApplicationController
  before_action :check_user, only: [:edit, :update, :board]
  def home
    @front_page = Page.first
  end

  def create
    # Retrieve post from database
    @front_page = Page.new(home_params)

    # Mass Assign edited post attributes
    if @front_page.save
      flash[:success] = "Home Page updated!"
      # Show success message and redirect to blog
      redirect_to root_path
    else
      render action: :edit
    end
  end

  def edit
    @front_page = Page.first
    if !@front_page.present?
      @front_page = Page.new
    end
  end

  def update
    # Retrieve post from database
    @front_page = Page.first

    # Mass Assign edited post attributes
    if @front_page.update_attributes(home_params)
      flash[:success] = "Home Page updated!"
      # Show success message and redirect to blog
      redirect_to root_path
    else
      render action: :edit
    end
  end

  def board

    if !current_user.superadmin_role
      redirect_to root_path, notice: "You have to be the chair to do that"

    else
      @chair = User.where(superadmin_role: '1')
      @board = User.where(supervisor_role: '1').where(superadmin_role: '0')

    end

  end

  def search

      if params[:query]



          @name = params[:query].split(" ")
          @new = User.where(first_name: @name[0], last_name: @name[1]).first

          if @new.present?

            if @new.supervisor_role = '0'

              @new.supervisor_role = '1'
              @new.superadmin_role = '0'
              @new.save
              redirect_to board_path, notice: "Board member succesfully added"

            else

              redirect_to board_path, notice: @new.first_name + " " + @new.last_name + " is already a board member"

            end

          else

          redirect_to board_path, notice: "User does not exist"

        end

      end

  end

  def removeBoard

    @user = User.find(params[:id])
    #@a = Assignment.where(user_id: @user.id).pluck('document_id')
    @x = Assignment.where(document_id: Document.where(is_archived: 'no'), user_id: @user.id)
    @v = Vote.where(document_id: Document.where(is_archived: 'no'), user_id: @user.id)

    @x.each do |x|
        x.destroy
    end
    @v.each do |v|
      v.destroy
    end

    @user.superadmin_role = '0'
    @user.supervisor_role = '0'
    @user.save
    redirect_to board_path, notice: "Board member succesfully removed"

end

  def removeChair

    @chairMems = User.where(superadmin_role: '1')

    if @chairMems.size > 1

      @user = User.find(params[:id])
      @user.supervisor_role = '1'
      @user.superadmin_role = '0'
      @user.save
      redirect_to board_path, notice: "Chair member was succesfully demoted"

    else
      redirect_to board_path, notice: "Please name a new chair first"

    end

  end

  def addChair

    @user = User.find(params[:id])
    @user.supervisor_role = '1'
    @user.superadmin_role = '1'
    @user.save
    redirect_to board_path, notice: "Board member was succesfully promoted to chair"

  end

  def addBoard

    @new = User.find(params[:id])
    @new.supervisor_role = '1'
    @new.superadmin_role = '0'
    @new.save
    redirect_to board_path, notice: "Board member added succesfully"

  end


  private
    def check_user
      if (!user_signed_in?)
        redirect_to root_path, notice: 'You must log in to do that'
      end
    end
    # strong params
    def home_params
       params.require(:page).permit(:title, :content)
    end

    def search_params
        params.require(:user).permit(:first_name, :last_name)
    end

end
