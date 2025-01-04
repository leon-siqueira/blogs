class CommentsController < ApplicationController

  allow_unauthenticated_access only: %i[ create ]


  # POST post/:post_id/comments
  def create
    @comment = Comment.new(comment_params)
    @comment.user = Current.user if authenticated?

    if @comment.save
      flash[:success] = "Comment was successfully created."
      redirect_to post_path(@comment.post)
    else
      flash[:alert] =  "Could not create the comment."
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
