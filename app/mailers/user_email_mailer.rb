class UserEmailMailer < ApplicationMailer
    # When someone submits an application, send them an email
    def submit_document(user)
        @user = user
        mail(to: @user, subject: "Your IRB Document was Submitted")
    end
  # When your application is reviewed, send them an email
	def update_document(user)
		@user = user
		mail(to: @user, subject: "Your IRB Document was Reviewed")
  end
  # When someone resubmits their revisions, let the chair know
  def resubmit(document)
    @document = document
    @user = User.find(@document.user_id)
    @chair = User.where(superadmin_role: '1').last
    mail(to: @chair.email, subject: "A Previously Submitted IRB Application has been resubmitted")
  end
  # When a board member gets assigned to an application, send them an email
  def assign(user_id)
    @user = User.find(user_id)
    mail(to: @user.email, subject: "You have been assigned to new IRB applications")
  end

  # When someone submits an application, send the chair an email
  def new_app(document)
    @document = document
    @user = User.find(@document.user_id)
    @chair = User.where(superadmin_role: '1').last
    mail(to: @chair.email, subject: "A new IRB Application has been submitted")
  end

  # When an application is reaching its one year mark, let chair and user know
  def yearlong(document)
    @document = document
    @user = User.find(@document.user_id)
    @chair = User.where(superadmin_role: '1').last
    mail(to: @chair.email, subject: "An IRB application is approaching the one year mark")
  end

  def yearlongresubmit(document)
    @document = document
    @user = User.find(@document.user_id)
    mail(to: @document.email, subject: "An IRB application is approaching the one year mark")
  end
end
