class UsersFacade
  def self.create_user(user_params)
    if User.find_by(email: user_params[:email])
      Error.new('That email already exists!')
    elsif user_params[:password] != user_params[:password_confirmation]
      Error.new('Passwords must match!')
    else
      UsersService.create_user(user_params)
    end
  end

  def self.check_credentials(user_params)
    user = User.find_by(email: user_params[:email])
    if user
      UsersService.check_credentials(user, user_params)
    else
      Error.new('That email and password combination does not exist!')
    end
  end
end
