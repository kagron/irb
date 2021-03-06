class AssignmentsController < ApplicationController

  # POST request to /applications/assignments
  def create
    # Check if any parameters were passed in a POST request
    # If nothing was passed, redirect back
    if !params[:document_id].present?
      redirect_to applications_new_apps_path, notice: 'Please select one or more applications' and return
    elsif !params[:user_id].present?
      redirect_to applications_new_apps_path, notice: 'Please select one or more board members' and return
    end
    if (params[:commit] == 'Delete')
      # if the delete pseudo-method is passed, go to the destroy method instead
      destroy and return
    end
    # "document_id"=>["5", "1"], "user_id"=>["1", "3"],
    # create a boolean to determine whether or not errorStr is returned back
    @isAllCorrect = true
    # create an empty error string array for holding errors
    @errorStr = Array.new
    # go through EACH user AND document passed through the POST request
    # params stores POST and GET data

    params[:user_id].each do |u|
      # I'm not sure if this does anything anymore
      @has_assigment = false
      params[:document_id].each do |d|
        @assignment = Assignment.new()
        @assignment.document_id = d
        @assignment.user_id = u
        # check if assignment already exists
        if !assignment_check(@assignment)
          # if assignment does NOT exist, save the assignment and check for votes using the vote_check method
          @assignment.save
          UserEmailMailer.assign(u).deliver
          vote_check(u, d)
        else
          # assignment already exists, so we add to the error string and change
          # @isAllCorrect to false so it will display error string
          @current_document = Document.find(d)
          @current_user = User.find(u)
          @isAllCorrect = false
          @errorStr.push("#{@current_document.project_title} is already assigned to #{@current_user.first_name}")
          # redirect_to applications_new_apps_path, notice: "#{@current_document.project_title} is already assigned to #{@current_user.first_name}" and return
        end
      end
    end
    if @isAllCorrect
      # if everything is correct, display no errors
      redirect_to applications_new_apps_path, notice: "Application(s) assigned successfully" and return
    else
      # if something is wrong, display the error instead.  Note: This will still
      # save any assignments that didn't have errors, but we didn't want to display errors
      # AND successful assignments
      redirect_to applications_new_apps_path, notice: @errorStr.join("<br />").html_safe and return
    end
  end

  # DELETE request to applications/assignments
  def destroy
      # This method is essentially the same as create but deleting
      # "document_id"=>["5", "1"], "user_id"=>["1", "3"],
      @isAllCorrect = true
      # create an empty error string
      @errorStr = Array.new
      # go through EACH user AND document passed through the POST request
      # params stores POST and GET data

      params[:document_id].each do |d|
        params[:user_id].each do |u|
          @assignment = Assignment.where(user_id: u, document_id: d)
          # @assignment = Assignment.new()
          # @assignment.document_id = d
          # @assignment.user_id = u
          # check if assignment exists
          if @assignment.present?
            # if assignment does exist, destroy the assignment
            # the ! makes it important, and will cause a runtime error if something
            # happens in this process.  Without the ! it would display nothing
            # So basically this was for debugging, you can get rid of the !
            @assignment[0].destroy!
          else
            # assignment does not exist, so we add to the error string and change
            # @isAllCorrect to false so it will display error string
            @current_document = Document.find(d)
            @current_user = User.find(u)
            @isAllCorrect = false
            @errorStr.push("The assignment between #{@current_document.project_title} and #{@current_user.first_name} does not exist")
            # redirect_to applications_new_apps_path, notice: "#{@current_document.project_title} is already assigned to #{@current_user.first_name}" and return
          end
        end
      end
      if @isAllCorrect
        # if everything is correct, display no errors
        redirect_to applications_new_apps_path, notice: "Assignment(s) deleted successfully"
      else
        # if something is wrong, display the error instead
        redirect_to applications_new_apps_path, notice: @errorStr.join("<br />").html_safe
      end
  end

  private
    def assignment_params
      # Whitelist these two params for the database so no one can add something
      params.require(:assignment).permit(:document_id,:user_id)
    end
    def vote_check(user_id, document_id)
      # Checks if current user has a vote associated with that document
      @vote = Vote.where(user_id: user_id, document_id: document_id)
      if !@vote.present?
        # if vote is NOT present, it will create one
        @newVote = Vote.new
        @newVote.user_id = user_id
        @newVote.document_id = document_id
        @newVote.state = 'new_app'
        @newVote.save
      end
    end
    def assignment_check(assignment)
      # check to see if that current assignment already exists
      @assignment_ids = Assignment.ids
      @assignment_to_check = assignment
      @old_assignment = Assignment.where(user_id: @assignment_to_check.user_id, document_id: @assignment_to_check.document_id)
      if @old_assignment.present?
        # if that assignment already exists, return true
        @isAssigned = true
      else
        @isAssigned = false
      end
      return @isAssigned
    end

end
