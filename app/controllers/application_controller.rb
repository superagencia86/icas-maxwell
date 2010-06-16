# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  before_filter :set_locale_from_url
  protect_from_forgery # See ActionController::RequestForgeryProtection for details
  helper_method :current_space, :current_user, :logged_in?

  # Scrub sensitive parameters from your log
  filter_parameter_logging :password

  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = exception.message
    redirect_to root_url
  end

  private
    def logged_in?
      !!current_user
    end

    def load_space
      @space ||= Space.find_by_permalink(params[:space_id])
      @space = current_space if @space.nil?
    end

    def current_space
      @current_space ||= current_user.space if current_user
    end

    def current_user_session
      return @current_user_session if defined?(@current_user_session)
      @current_user_session = UserSession.find
    end

    def current_user
      return @current_user if defined?(@current_user)
      @current_user = current_user_session && current_user_session.user
    end

    def require_user
      unless current_user
        store_location
        flash[:notice] = "Debes estar logueado para acceder a esta página"
        redirect_to login_path
        return false
      end
    end
 
    def require_no_user
      if current_user
        store_location
        redirect_to root_url
        return false
      end
    end
    

    def store_location
      session[:return_to] = request.request_uri
    end
    
    def redirect_back_or_default(default)
      redirect_to(session[:return_to] || default)
      session[:return_to] = nil
    end
    
end
