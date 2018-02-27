class AssignmentsController < ApplicationController

  def create
    # "document_id"=>["5", "1"], "user_id"=>["1", "3"],
    @isAllCorrect = true
    @errorStr = Array.new
    params[:document_id].each do |d|
      params[:user_id].each do |u|
        @assignment = Assignment.new()
        @assignment.document_id = d
        @assignment.user_id = u
        if !assignment_check(@assignment)
          @assignment.save
        else
          @current_document = Document.find(d)
          @current_user = User.find(u)
          @isAllCorrect = false
          @errorStr.push("#{@current_document.project_title} is already assigned to #{@current_user.first_name}")
          # redirect_to applications_new_apps_path, notice: "#{@current_document.project_title} is already assigned to #{@current_user.first_name}" and return
        end
      end
    end
    if @isAllCorrect
      redirect_to applications_new_apps_path, notice: "Application(s) assigned successfully" and return
    else
      redirect_to applications_new_apps_path, notice: @errorStr.join("<br />").html_safe and return
    end
    # redirect_to applications_new_apps_path, notice: "success"
    # @users = User.where(supervisor_role: '1')
    # @assignment = Assignment.new()
    # @assignment.document_id = params[:document_id][0]
    # @assignment.user_id = params[:user_id][0]

    # if !assignment_check(@assignment)
    #   respond_to do |format|
    #       if @assignment.save!
    #         format.html { redirect_to applications_new_apps_path, notice: 'Application assigned succesfully' }
    #         format.json { render :show, status: :created, location: @assignment }
    #       else
    #         format.html { redirect_to applications_new_apps_path, notice: 'There was a problem assigning that application'}
    #         format.json { render json: @assignment.errors, status: :unprocessable_entity }
    #       end
    #
    #   end
    # else
    #   redirect_to applications_new_apps_path, notice: 'That person has already been assigned to that application'
    # end
  end

  private
    def assignment_params
      params.require(:assignment).permit(:document_id,:user_id)
    end

    def assignment_check(assignment)

      @assignment_ids = Assignment.ids
      @assignment_to_check = assignment
      @old_assignment = Assignment.where(user_id: @assignment_to_check.user_id, document_id: @assignment_to_check.document_id)
      if @old_assignment.present?
        @isAssigned = true
      else
        @isAssigned = false
      end

      # @assignment_ids.each do |a|
      #   if a == @assignment_to_check.document_id
      #     @isAssigned = false
      #   else
      #     @isAssigned = true
      #   end
      # end
      return @isAssigned
    end

end
