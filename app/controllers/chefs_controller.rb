class ChefsController < ApplicationController
  
  #We will have a common line EDIT, UPDATE, and SHOW action. We want to call it one time
  before_action :set_chef, only: [:edit, :show, :update]
  #User may write a URL of another to get permission to manipulate his information. We need to secure all actions in this controller. 
  #So we'll define and excute private methods before any action called to check the current, logged in user if he has permission to perform that action. We do it by BEFORE_ACTION then we put our private methods.
  #We need stop any user trying to update other users' profile. We need to check this authorization only for EDIT & UPDATE action. So we defined REQUIRE_SAME_USER method to do this
  before_action :require_same_user, only: [:edit, :update]
  
  #The information from "NEW" action will be posted to "CREATE" action. So we have to define "CREATE" action
  def new
    @chef = Chef.new
  end
  
  #The "CREATE" action does not need view since its type is "POST"
  def create
    @chef = Chef.new(chef_params)
    if @chef.save
      flash[:success] = "Your account is registered successfully"
      #And we need to create a session
      session[:chef_id] = @chef.id
      redirect_to recipes_path
    else
      render 'new'
    end
  end
  
  #The information from "EDIT" action will be posted to "CREATE" action. So we have to define "UPDATE" action
  def edit
    #SET_CHEF method will be called form BEFORE_ACTION
  end
  
  #The "UPDATE" action does not need view since its type is "POST"
  def update
    #SET_CHEF method will be called form BEFORE_ACTION
    #In update we must use the method of whitelisted parameters
    if @chef.update(chef_params)
      flash[:success] = "You profile is updated successfully"
      redirect_to chef_path(@chef)
    else
      render 'edit'
    end
  end
  
  def show
    #SET_CHEF method will be called form BEFORE_ACTION
    #We need pagination for Chefs' Recipes.
    @recipes = @chef.recipes.paginate(page: params[:page], per_page:1)
  end
  
  def index
    @chefs = Chef.paginate(page: params[:page], per_page: 1)
  end
  
  private
   def chef_params
     params.require(:chef).permit(:chefname, :email, :password)
   end
   
    #This method will be excuted if any action defined in BEFORE_ACTION is called
    def set_chef
      #We should define this line for SHOW, EDIT, UPDATE,  but we will call it from this method using BEFORE_ACTION at the beginning of this controller
     @chef = Chef.find(params[:id])
    end
    
    def require_same_user
      if current_user != @chef
        flash[:danger] = "You can only edit your own profile"
        redirect_to root_path
      end
    end
    
end