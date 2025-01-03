class PostsController < ApplicationController
  before_action :set_post, only: %i[ show edit update destroy ]
  allow_unauthenticated_access only: %i[ index show ]
  before_action -> { authorize @post || Post.new }, only: %i[ edit update destroy ]

  # GET /posts
  def index
    @posts = Post.order(created_at: :desc).page(params[:page] || 1).per(3)
  end

  # GET /posts/1
  def show
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  def create
    @post = Post.new(post_params)
    @post.user = Current.user
    if @post.save
      flash[:success] = "Post was successfully created."
      redirect_to @post
    else
      flash[:alert] =  "Could not create the post."
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /posts/1
  def update
    if @post.update(post_params)
      flash[:success] = "Post was successfully updated."
      redirect_to @post
    else
      flash[:alert] =  "Could not update the post."
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /posts/1
  def destroy
    if @post.destroy
      flash[:success] = "Post was successfully destroyed."
      redirect_to posts_path, status: :see_other
    else
      flash[:alert] =  "Could not delete the post."
      redirect_to @post, status: :unprocessable_entity
    end
  end

  private

    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def post_params
      params.require(:post).permit(:title, :content)
    end
end
