module Users
  class UsersApi < BaseApi
    
    params do
      requires :user, type: Hash do
        requires 'email', type: String, desc: "Email"
        requires 'password', type: String, desc: "Password"
      end
    end
    post 'sign_in' do
      sign_in_params=params[:user]
      user = User.find_by_email(sign_in_params[:email])
      if user && user.valid_password?(sign_in_params[:password])
        @current_user = user
        {token: @current_user.generate_jwt}
      else
        error!({ status: :error, message: 'email or password is invalid' }, 403)
      end
    end

    post 'sign_up' do
      sign_up_params=params[:user]
      user = User.create(sign_up_params)
      if user.save
        { status: :success }
      else
        error!({ status: :error, message: user.errors.full_messages.first }) if user.errors.any?
      end
    end

    get 'current' do
      authenticate!
      {user: @current_user}
    end
  end
end