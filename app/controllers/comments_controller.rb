class CommentsController < ApplicationController
  before_action :set_comment, only: [:destroy]
  before_action :set_commentable

  # POST /comments
  # POST /comments.json
  def create
    @comment = @commentable.comments.new(comment_params.merge(user: current_user))

    respond_to do |format|
      if @comment.save
        format.html { redirect_to @commentable, notice: t('controllers.common.notice_create', name: Comment.model_name.human) }
      else
        format.html { redirect_to @commentable, notice: t('errors.template.header.one', model: Comment.model_name.human) }
      end
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
    if @comment.user_id == current_user.id
      @comment.destroy
      respond_to do |format|
        format.html { redirect_to @commentable, notice: t('controllers.common.notice_destroy', name: Comment.model_name.human) }
      end
    else
      redirect_to @commentable
    end  
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end

    def set_commentable
      resource, id = request.path.split('/')[1,2]
      @commentable = resource.singularize.classify.constantize.find(id)
    end

    # Only allow a list of trusted parameters through.
    def comment_params
      params.require(:comment).permit(:body, :user_id, :commentable_id, :commentable_type)
    end
end
