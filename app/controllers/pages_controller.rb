class PagesController < ApplicationController
  def home
    #Here we want to redirect the user to RECIPES PAGE to be his home page if he is logged in. So we'll call LOGEED_IN method from APPLICATION CONTROLLER to check if he's logged in
    redirect_to recipes_path if logged_in?
  end
end