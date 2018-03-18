class VotesController < ApplicationController
  before_action :check_user
  def approve_vote
    @document = Document.find(params[:id])
    @user = current_user
    @vote = Vote.where(user_id: @user.id, document_id: @document.id)
    @vote[0].state = 'approved'
    @vote[0].save
    redirect_to @document, notice: 'You successfully voted to change the state to Approved'

  end

  def revise_vote
    @document = Document.find(params[:id])
    @user = current_user
    @vote = Vote.where(user_id: @user.id, document_id: @document.id)
    @vote[0].state = 'needs_revisions'
    @vote[0].save
    redirect_to @document, notice: 'You successfully voted to change the state to Approved Pending Revisions'
  end

  def reject_vote
    @document = Document.find(params[:id])
    @user = current_user
    @vote = Vote.where(user_id: @user.id, document_id: @document.id)
    @vote[0].state = 'rejected'
    @vote[0].save
    redirect_to @document, notice: 'You successfully voted to change the state to Rejected'
  end

  def approve
    # Approve the application
    @document = Document.find(params[:id])
    @document.state = 'approved'
    @document.is_archived = 'yes'
    @document.update(document_params)
    # Email the investigator
    UserEmailMailer.update_document(@document.email).deliver
    # TODO: put approved on each submitted document
    @files = Array.new
    # push all the documents files into an array
    @files.push(@document.child_assent_file.file.path) if @document.child_assent_file.present?
    @files.push(@document.hsr_certificate_file.file.path) if @document.hsr_certificate_file.present?
    @files.push(@document.questions_file.file.path) if @document.questions_file.present?
    @files.push(@document.consent_file.file.path) if @document.consent_file.present?
    @files.push(@document.written_permission_file.file.path) if @document.written_permission_file.present?
    # merge the stamp in a loop
    if @files.present?
      @files.each do |file|
        stamp = CombinePDF.load("stamp.pdf").pages[0]
        pdf = CombinePDF.load(file)
        pdf.pages.each {|page| page << stamp}
        pdf.save file
      end
    end
    redirect_to @document, notice: 'You successfully changed the state to Approved'
  end

  # POST to applications/:id/revise
  def revise
    # Change document state to needs_revisions
    @document = Document.find(params[:id])
    @document.state = 'needs_revisions'
    @document.update(document_params)
    # Email User that their document has been reviewed
    UserEmailMailer.update_document(@document.email).deliver
    # Reset votes and assignments
    # We can assume that the current votes and assignments are only board members
    @current_votes = Vote.where(document_id: @document.id)
    @current_assignments = Assignment.where(document_id: @document.id)
    @current_votes.each do |vote|
      vote.destroy
    end
    @current_assignments.each do |assignment|
      assignment.destroy
    end
    @board_members = User.where(supervisor_role: '1')
    @board_members.each do |member|
      @empty_vote = Vote.new
      @empty_vote.user_id = member.id
      @empty_vote.document_id = @document.id
      @empty_vote.state = 'new_app'
      @empty_vote.save
    end
    # redirect back to application
    redirect_to @document, notice: 'You successfully changed the state to Approved Pending Revisions'
  end

  def reject
    @document = Document.find(params[:id])
    @document.state = 'rejected'
    @document.is_archived = 'yes'
    @document.update(document_params)
    UserEmailMailer.update_document(@document.email).deliver
    redirect_to @document, notice: 'You successfully changed the state to Rejected'
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
