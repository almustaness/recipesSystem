class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  #By declaring this line, All methodes will be also availabe to all views
  helper_method :current_user, :logged_in?
  
  #We need methods to make them availabe in all controllers. So we define them in APPLICATION CONTROLLER. But these methods will not be available to views withot helper
  def current_user
    # "||=" this means do not hit the DB each time if there is a session but use @CURRENT_USER
    @current_user ||= Chef.find(session[:chef_id]) if session[:chef_id]
  end
  
  def logged_in?
    #Here we need a boolean to check the user if he is logged in. So we can use "!!" to call this value from CURRENT_USER method
    !!current_user
  end
  
  def require_user
    if !logged_in?
      flash[:danger] = "You have to be logged in to perform this action"
      redirect_to root_path
    end
  end
end
