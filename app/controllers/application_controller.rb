class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  protect_from_forgery with: :exception
  def after_sign_in_path_for(resource)
    user_path(current_user.id)
  end

  def after_sign_up_path_for(resource)
    user_path(current_user.id)
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    devise_parameter_sanitizer.permit(:sign_up, keys: [:icon])
    devise_parameter_sanitizer.permit(:sign_up, keys: [:avator])
    devise_parameter_sanitizer.permit(:sign_up, keys: [:profile])
    devise_parameter_sanitizer.permit(:account_update, keys: [:icon])
    devise_parameter_sanitizer.permit(:account_update, keys: [:avator])
    devise_parameter_sanitizer.permit(:account_update, keys: [:profile])
  end
end
