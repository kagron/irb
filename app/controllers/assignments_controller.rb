class AssignmentsController < ApplicationController

  def create
    @user = current_user
    @assignment = Assignment.new(assignment_params)
    @document = Document.find(params[:id])
    @assignment.document_id = @document.id
    @assignment_params.user_id = @user.id
    @assignment.fname = @user.first_name
    @assignment.lname = @user.last_name

    respond_to do |format|
      if @comment.save
        format.html { redirect_to applications_new_apps_path,notice: 'Comment was successfully added' }
        format.json { render :show, status: :created, location: @assignment }
      else
        format.html { render :new }
        format.json { render json: @assignment.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    def assignment_params
      params.require(:comment).permit(:documents_id,:users_id)
    end
end
