class UserEmailMailer < ApplicationMailer
    def submit_document(user)
        @user = user
        mail(to: @user, subject: "IRB Submitted!")
    end

	def update_document(user)
		@user = user
		mail(to: @user, subject: "Your IRB application has been reviewed.")
  end
end
