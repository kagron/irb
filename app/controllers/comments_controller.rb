class CommentsController < ApplicationController

  def create
    @user = current_user
    @comment = Comment.new(comment_params)
    @document = Document.find(params[:id])
    @comment.document_id = @document.id
    @comment.user_id = @user.id
    @comment.fname = @user.first_name
    @comment.lname = @user.last_name

    respond_to do |format|
      if @comment.save
        format.html { redirect_to @document, notice: 'Comment was successfully added' }
        format.json { render :show, status: :created, location: @document }
      else
        format.html { render :new }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    def comment_params
      params.require(:comment).permit(:content, :title, :fname, :lname, :documents_id,
      :users_id)
    end
end
