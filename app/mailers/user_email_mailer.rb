class UserEmailMailer < ApplicationMailer
    def submit_document(user)
        @user = user
        mail(to: @user, subject: "IRB Document Submitted")
    end

	def update_document(user)
		@user = user
		mail(to: @user, subject: "YIRB Document Reviewed")
  end
end
