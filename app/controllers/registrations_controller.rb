class RegistrationsController < Devise::RegistrationsController

  private
    # Added name to the RegistrationsController
    def sign_up_params
      params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
    end
    # Added name to the RegistrationsController
    def account_update_params
      params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :current_password)
    end
end
