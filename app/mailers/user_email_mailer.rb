class UserEmailMailer < ApplicationMailer
    def submit_document(user)
        @user = user
        mail(to: @user, subject: "Your IRB Document was Submitted")
    end

	def update_document(user)
		@user = user
		mail(to: @user, subject: "Your IRB Document was Reviewed")
  end

  def resubmit(document)
    @document = document
    @user = User.find(@document.user_id)
    @chair = User.where(superadmin_role: '1').last
    mail(to: @chair.email, subject: "A Previously Submitted IRB Application has been resubmitted")
  end

  def assign(user_id)
    @user = User.find(user_id)
    mail(to: @user.email, subject: "You have been assigned to new IRB applications")
  end

  def new_app(document)
    @document = document
    @user = User.find(@document.user_id)
    @chair = User.where(superadmin_role: '1').last
    mail(to: @chair.email, subject: "A new IRB Application has been submitted")
  end

  def yearlong(document)
    @document = document
    @user = User.find(@document.user_id)
    @chair = User.where(superadmin_role: '1').last
    mail(to: @chair.email, subject: "An IRB application is approaching the one year mark")
  end

  def yearlongresubmit
    @document = document
    @user = User.find(@document.user_id)
    mail(to: @user.email, subject: "An IRB application is approaching the one year mark")
  end
end
