module AuthenticationHelpers
  def log_in(user, password: "password", remember_me: true)
    post login_path, params: {
      user: {
        email: user.email,
        password: password,
        remember_me: remember_me ? "1" : "0",
      }
    }
  end

  def log_out
    delete logout_path
  end
end