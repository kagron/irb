class UserEmailMailer < ApplicationMailer
    def submit_document(user)
        @user = user
        mail(to: @user, subject: "IRB Submitted!")
    end
end
