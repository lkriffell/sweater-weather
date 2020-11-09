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
end
