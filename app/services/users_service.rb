class UsersService
  def self.create_user(user_params)
    User.create({
                email: user_params[:email],
                password: user_params[:password],
                api_key: User.generate_api_key
                })
  end
end
