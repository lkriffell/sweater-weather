class UsersService
  def self.create_user(user_params)
    User.create({
                email: user_params[:email],
                password: user_params[:password],
                api_key: User.generate_api_key
                })
  end

  def self.check_credentials(user, user_params)
    if user.authenticate(user_params[:password])
      return user
    else
      Error.new('That email and password combination does not exist!')
    end
  end
end
