class ChairCommentsController < ApplicationController


  # POST to /chair_comments
  def create
    # Grab the current user
    @user = current_user
    @comment = ChairComment.new(comment_params)
    # Grab the application the chair's comment is associated with by grabbing the ID in an array of an array passed
    # through a POST request
    @document = Document.find(params[:chair_comment][:document_id])
    @comment.document_id = @document.id
    @comment.user_id = @user.id

    respond_to do |format|
      if @comment.save
        # If comment was saved, redirect back to the applicatoin
        format.html { redirect_to @document, notice: 'Comment was successfully added' }
        format.json { render :show, status: :created, location: @document }
      else
        # if save failed, go back and display errors
        format.html { render :new }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH request to /
  # I'm not really sure why this is a patch request to root, so don't hurt us
  def update
    # Grab the application by the ID in the params associative array
    @document = Document.find(params[:chair_comment][:document_id])
    @comment = ChairComment.where(document_id: params[:chair_comment][:document_id]).last
    if @comment.update(comment_params)
    		# @newstate = @document.state
        # @document.is_resubmitted = true
        redirect_to document_path(@document), notice: 'Comment was successfully updated.'
      else
        format.html { render :edit }
        format.json { render json: @document.errors, status: :unprocessable_entity }
      end
  end

  def destroy

  end

  private
  # Only allow one parameter to come through this controller 
    def comment_params
      params.require(:chair_comment).permit(:body)
    end
end
