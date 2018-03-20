class IrbController < ApplicationController
  before_action :check_user, only: [:edit, :update]
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

  def ArchivedApps
    if params[:search]
     @data = Document.search(params[:search]).where(:is_archived => '1').order("created_at DESC")
    else
      @data = Document.where(:is_archived => '1').order("created_at DESC")
    end
  end


  def self.search(search)
	   where("id LIKE ? OR fName LIKE ? OR lName LIKE ? OR phone LIKE ? OR email LIKE ? OR department LIKE ? OR typeOfApplication LIKE ? OR project_title LIKE ? OR sponsor_name LIKE ? OR start_date LIKE ? OR end_date LIKE ? OR state LIKE ?", "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%")
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

end
