class AssignmentsController < ApplicationController

  def create
    @users = User.where(supervisor_role: '1')
    @assignment = Assignment.new(assignment_params)
    @assignment.document_id = params[:document_id]
    @assignment.user_id = params[:user_id]


    respond_to do |format|
      if @assignment.save
        format.html { redirect_to applications_new_apps_path, notice: 'Document assigned succesfully' }
        format.json { render :show, status: :created, location: @assignment }
      else
        format.html { render :new }
        format.json { render json: @assignment.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    def assignment_params
      params.require(:assignment).permit(:documents_id,:users_id)
    end
end
