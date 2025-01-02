class PostPolicy
  attr_reader :user, :post

  def initialize(user, post)
    @user = user
    @post = post
  end

  def edit?
    @post.user_id == @user.id
  end

  def update?
    edit?
  end

  def destroy?
    edit?
  end

  private

  def user_owns_post?
    post.user_id == user.id
  end
end
