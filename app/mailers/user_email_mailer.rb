class UserEmailMailer < ApplicationMailer
    def submit_document(user)
        @user = user
        mail(to: @user, subject: "Your IRB Document was Submitted")
    end

	def update_document(user)
		@user = user
		mail(to: @user, subject: "Your IRB Document was Reviewed")
  end
end
