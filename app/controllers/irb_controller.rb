class IrbController < ApplicationController
  def FormApps
    if params[:search]
      @data = Document.search(params[:search]).order("created_at DESC")#.where(:is_archived => '0') #1isArchived
    else
      @data = Document.all.order("created_at DESC")#.where(:is_archived => '0')
    end
  end

  def ArchivedApps
    if params[:search]
     @data = Document.search(params[:search]).where(:is_archived => '1').order("created_at DESC")
    else
      @data = Document.where(:is_archived => '1').order("created_at DESC")
    end
  end

  def InProgressApps
  end

  def StateApps
  end

  def self.search(search)
	   where("id LIKE ? OR fName LIKE ? OR lName LIKE ? OR phone LIKE ? OR email LIKE ? OR department LIKE ? OR typeOfApplication LIKE ? OR project_title LIKE ? OR sponsor_name LIKE ? OR start_date LIKE ? OR end_date LIKE ? OR state LIKE ?", "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%")
  end


end
