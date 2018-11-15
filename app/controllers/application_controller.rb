class ApplicationController < ActionController::Base
  before_action :redirect_authenticated_users
  helper_method :current_user

  def current_user
  @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def require_user
  redirect_to '/login' unless current_user
  end

private

  def redirect_authenticated_users
    return if !current_user
    redirect_to '/articles' if request.path =~ /signup|login/ 

  end


end
