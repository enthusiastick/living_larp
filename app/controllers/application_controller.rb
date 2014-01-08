class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  protected

  def authenticate_user
    unless user_signed_in?
      raise ActionController::RoutingError.new('Not Found')
    end
  end

  def set_user
    @user = current_user
  end

end
