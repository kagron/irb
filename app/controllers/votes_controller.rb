class VotesController < ApplicationController
  before_action :check_user
  def approve
    @document = Document.find(params[:id])
    @user = current_user
    @vote = Vote.where(user_id: @user.id, document_id: @document.id)
    if (current_user.superadmin_role && @vote[0].state != 'new_app')
      @document.state = 'approved'
      @document.update(document_params)
      UserEmailMailer.update_document(@document.email).deliver
      redirect_to @document, notice: 'You successfully changed the state to Approved'
    else
      @vote[0].state = 'approved'
      @vote[0].save
      redirect_to @document, notice: 'You successfully voted to change the state to Approved'
    end
  end

  def revise
    @document = Document.find(params[:id])
    @user = current_user
    @vote = Vote.where(user_id: @user.id, document_id: @document.id)
    if (current_user.superadmin_role && @vote[0].state != 'new_app')
      @document.state = 'needs_revisions'
      @document.update(document_params)
      UserEmailMailer.update_document(@document.email).deliver
      redirect_to @document, notice: 'You successfully changed the state to Approved Pending Revisions'
    else
      @vote[0].state = 'needs_revisions'
      @vote[0].save
      redirect_to @document, notice: 'You successfully voted to change the state to Approved Pending Revisions'
    end
  end

  def reject
    @document = Document.find(params[:id])
    @user = current_user
    @vote = Vote.where(user_id: @user.id, document_id: @document.id)
    if (current_user.superadmin_role && @vote[0].state != 'new_app')
      @document.state = 'rejected'
      @document.update(document_params)
      UserEmailMailer.update_document(@document.email).deliver
      redirect_to @document, notice: 'You successfully changed the state to Rejected'
    else
      @vote[0].state = 'rejected'
      @vote[0].save
      redirect_to @document, notice: 'You successfully voted to change the state to Rejected'
    end
  end


  private
    def check_user
      if (!user_signed_in?)
        redirect_to root_path, notice: 'You must log in to do that'
      end
      # if (!current_user.superadmin_role)
      #   redirect_to root_path, notice: 'You do not have permissions to do that'
      # end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def document_params
      params.permit(:state)
    end
end
