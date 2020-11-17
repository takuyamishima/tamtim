class ApplicationController < ActionController::Base
  before_action :set_host
  before_action :configure_permitted_parameters, if: :devise_controller?

  protect_from_forgery with: :exception
  def after_sign_in_path_for(resource)
    user_path(current_user.id)
  end

  def after_sign_up_path_for(resource)
    root_path
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:name, :email, :accepted, :password, :uid, :provider, :icon) }
    devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:name, :email, :password, :profile, :icon,  :password, :coverimg, :tag) }
  end

  def set_host
    ActionMailer::Base.default_url_options = { :host => "https://" + request.host_with_port }
  end
end
