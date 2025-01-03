class CommentsController < ApplicationController
  before_action :set_comment, only: %i[ show edit update destroy ]

  # GET /comments
  def index
    @comments = Comment.all
  end

  # GET /comments/1
  def show
  end

  # GET /comments/new
  def new
    @comment = Comment.new
  end

  # GET /comments/1/edit
  def edit
  end

  # POST /comments
  def create
    @comment = Comment.new(comment_params)

    if @comment.save
      flash[:success] = "Comment was successfully created."
      redirect_to @comment
    else
      flash[:alert] =  "Could not create the comment."
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /comments/1
  def update
    if @comment.update(comment_params)
      flash[:success] = "Comment was successfully updated."
      redirect_to @comment
    else
      flash[:alert] =  "Could not update the comment."
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /comments/1
  def destroy
    @comment.destroy!
    flash[:success] = "Comment was successfully destroyed."
    redirect_to comments_path, status: :see_other
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
