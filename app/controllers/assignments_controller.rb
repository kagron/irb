class AssignmentsController < ApplicationController

  def create
    @users = User.where(supervisor_role: '1')
    @assignment = Assignment.new()
    @assignment.document_id = params[:document_id][0]
    @assignment.user_id = params[:user_id][0]


    respond_to do |format|
      if @assignment.save!
        format.html { redirect_to applications_new_apps_path, notice: 'Document assigned succesfully' }
        format.json { render :show, status: :created, location: @assignment }
      else
        format.html { redirect_to applications_new_apps_path, notice: 'There was a problem assigning the document'}
        format.json { render json: @assignment.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    def assignment_params
      params.require(:assignment).permit(:document_id,:user_id)
    end
end
