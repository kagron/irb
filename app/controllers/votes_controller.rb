class VotesController < ApplicationController
  before_action :check_user
  def approve
    @document = Document.find(params[:id])
    if (current_user.superadmin_role)
      @document.state = 'approved'
      @document.save
      UserEmailMailer.update_document(current_user.email).deliver
      redirect_to @document, notice: 'You successfully changed the state to Approved'
    else
      @vote = Vote.new
      @user = current_user
      @vote.document_id = @document.id
      @vote.user_id = @user.id
      @vote.state = 'approved'
      @vote.save
      redirect_to @document, notice: 'You successfully voted to change the state to Approved'
    end
  end

  def revise
    @document = Document.find(params[:id])
    if (current_user.superadmin_role)
      @document.state = 'needs_revisions'
      @document.save
      UserEmailMailer.update_document(current_user.email).deliver
      redirect_to @document, notice: 'You successfully changed the state to Approved Pending Revisions'
    else
      @vote = Vote.new
      @user = current_user
      @vote.document_id = @document.id
      @vote.user_id = @user.id
      @vote.state = 'needs_revisions'
      @vote.save
      redirect_to @document, notice: 'You successfully voted to change the state to Approved Pending Revisions'
    end
  end

  def reject
    @document = Document.find(params[:id])
    if (current_user.superadmin_role)
      @document.state = 'rejected'
      @document.save
      UserEmailMailer.update_document(current_user.email).deliver
      redirect_to @document, notice: 'You successfully changed the state to Rejected'
    else
      @vote = Vote.new
      @user = current_user
      @vote.document_id = @document.id
      @vote.user_id = @user.id
      @vote.state = 'rejected'
      @vote.save
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
end
