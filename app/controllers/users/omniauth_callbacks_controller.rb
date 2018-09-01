class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController  
  def facebook
    @user = User.find_for_facebook_oauth(request.env["omniauth.auth"])
    if @user
      sign_in_and_redirect @user, event: :authentication
      set_flash_message(:notice, :success, kind: "facebook") if is_navigational_format?
    else
      session['devise.facebook_data'] = request.env['omniauth.auth']
      
      @user = User.new()
      @user.provider = session['devise.facebook_data']['info']['provider']
      @user.email = session['devise.facebook_data']['info']['email']
      @user.uid = session['devise.facebook_data']['info']['uid']
      @user.name = session['devise.facebook_data']['info']['name']
      @user.icon = session['devise.facebook_data']['info']['image'] 
      render 'devise/registrations/new'
    end
  end

  def failure
    redirect_to root_path
  end
end