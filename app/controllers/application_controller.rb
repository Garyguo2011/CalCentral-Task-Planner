class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :require_login, :unless => :devise_controller?
  def require_login
   redirect_to new_user_session_path, alert: "You must be logged in to perform this action" if current_user.nil?
  end
   # rescue_from CanCan::AccessDenied do |e|
   #   redirect_to new_user_session_path, alert: e.message
   # end

  # def after_sign_in_path_for(resource)
    
  # end

  # def after_sign_out_path_for(resource_or_scope)
    
  # end

end
