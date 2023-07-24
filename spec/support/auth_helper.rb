module AuthHelper
  # This method is used to login the user before each test
  # @param user [User] the user to login
  def login_as(user)
    # let's hope that the post method hasn't been overridden...
    post '/api/v1/login', params: { email: user.email, password: user.password }
  end
end
