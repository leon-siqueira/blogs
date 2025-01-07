class CommentsController < ApplicationController
  allow_unauthenticated_access only: %i[ create ]


  # POST post/:post_id/comments
  def create
    @comment = Comment.new(comment_params)
    @comment.user = Current.user if authenticated?

    if @comment.save
      flash[:success] = I18n.t("flash_alerts.comments.create.success")
      redirect_to post_path(id: @comment.post_id)
    else
      flash[:alert] =  I18n.t("flash_alerts.comments.create.error")
      @post = @comment.post
      render "posts/show", status: :unprocessable_entity
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def comment_params
      params.require(:comment).permit(:content, :user_id, :post_id)
    end
end
