class ChairCommentsController < ApplicationController



  def create
    @user = current_user
    @comment = ChairComment.new(comment_params)
    @document = Document.find(params[:chair_comment][:document_id])
    @comment.document_id = @document.id
    @comment.user_id = @user.id

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

  def update

  end

  def destroy

  end

  private
    def comment_params
      params.require(:chair_comment).permit(:body)
    end
end
