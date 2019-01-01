class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    if anotherprovider?(:facebook)
      call_addsocial(:facebook)
    else
      callback_from :facebook
    end
  end

  def twitter
    if anotherprovider?(:twitter)
       call_addsocial(:twitter)
    else
      callback_from :twitter
    end
  end

  private

  def callback_from(provider)

    provider = provider.to_s
    auth = request.env['omniauth.auth']
    session[:oauth_token] = auth['credentials']['token']
    session[:oauth_token_secret] = auth['credentials']['secret']

    @user = User.find_for_oauth(auth)

    if @user.persisted?
      flash[:notice] = I18n.t('devise.omniauth_callbacks.success', kind: provider.capitalize)
      sign_in_and_redirect @user, event: :authentication
    else
      session["devise.#{provider}_data"] = request.env["omniauth.auth"].except("extra")
      redirect_to new_user_registration_url
    end
  end
    
  def call_addsocial(provider)
    auth = request.env['omniauth.auth']
    profile = SocialProfile.find_for_oauth(current_user.id, auth)
    if profile.persisted?
      redirect_to user_path(current_user), notice: t('.addsuccess')
    elsif profile.errors
      redirect_to user_path(current_user), notice: profile.errors.messages
    else
      redirect_to user_path(current_user), notice: t('.existserror')
    end
  end

  def anotherprovider?(provider)
    if current_user 
      return User.existsprovider?(current_user.id, provider)
    else
      return false
    end
  end
end
