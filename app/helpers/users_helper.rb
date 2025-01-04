module UsersHelper
  def form_options(usage, user)
    {
      register: {
        url: users_path,
        method: :post,
        submit: "Register"
      },
      edit: {
        url: (user_path(user) if user.persisted?),
        method: :patch,
        submit: "Update"
      }
    }[usage]
  end
end
