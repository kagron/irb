class CommentsController < ApplicationController

  # POST request applications/:id
  def create
    # Grab the user, create a new comment using strong parameters
    # Find the document using the ID that was passed in a POST request
    @user = current_user
    @comment = Comment.new(comment_params)
    @document = Document.find(params[:id])
    # Kyle: i had to associate the comment with the document and user
    # explicitly like this because rails associations weren't working with multiple
    # associations
    @comment.document_id = @document.id
    @comment.user_id = @user.id
    # Set the name
    @comment.fname = @user.first_name
    @comment.lname = @user.last_name

    respond_to do |format|
      # Save the comment
      if @comment.save
        format.html { redirect_to @document, notice: 'Comment was successfully added' }
        format.json { render :show, status: :created, location: @document }
      else
        # if save goes wrong, display errors on the page
        format.html { render :new }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    # destroy the comment
    @comment = Comment.find(params[:comment_id])
    @comment.destroy
    redirect_to document_path, notice: "Comment successfully deleted"
  end

  private
  # Strong parameters.  Only allow parameters that we state here
    def comment_params
      params.require(:comment).permit(:content, :title, :fname, :lname, :documents_id,
      :users_id)
    end
end
