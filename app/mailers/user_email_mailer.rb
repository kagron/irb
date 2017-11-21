class UserEmailMailer < ApplicationMailer
    default :from => "anthbarrios20@gmail.com"

    def submit_document(user)
        @user = user
        mail :to => @user.email, :subject => "IRB Submitted!"
end
