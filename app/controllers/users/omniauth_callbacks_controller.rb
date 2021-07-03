class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def twitter
    callback_for(:twitter)
  end

  private

  def callback_for(provider)
    provider = provider.to_s

    @user = User.find_for_oauth(request.env['omniauth.auth'])

    if @user.present? && provider == 'twitter'
      session[:oauth_token] = request.env['omniauth.auth']['credentials']['token']
      session[:oauth_token_secret] = request.env['omniauth.auth']['credentials']['secret']
      sign_in_and_redirect @user, event: :authentication
    elsif @user.present?
      sign_in_and_redirect @user, event: :authentication
    else
      redirect_to new_user_session_path
    end
  end
end
