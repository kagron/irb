class CommentsController < ApplicationController

  def create
    @user = current_user
    @comment = Comment.new(comment_params)
    @document = Document.find(params[:id])
    @comment.documents_id = @document.id
    @comment.users_id = @user.id

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
