module UsersHelper
  def form_options(usage, user)
    {
      register: {
        url: users_path,
        method: :post,
        submit: I18n.t("pages.users.form.submit.register")
      },
      edit: {
        url: (user_path(id: user) if user.persisted?),
        method: :patch,
        submit: I18n.t("pages.users.form.submit.update")
      }
    }[usage]
  end
end
