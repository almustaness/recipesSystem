#The name of the file of this controller is named with undescore. But the class of this controller should be Camel Case.
class RecipesController < ApplicationController
  before_action :set_recipe, only: [:edit, :show, :like, :update]
  before_action :require_same_user, only: [:edit, :update]
  #We want to restrict the user from performing any information manipulation if he is not logged in. But we want to allow him to see the content of our system.
  #REQUIRE_USER method will be defined in APPLICATION CONTROLLER since we will need to use it in other conrollers.
  before_action :require_user, except: [:index, :show]
  
  #We define index action here
  def index
    #We want to retrieve data from the database and pass these data to the "INDEX VIEW". We'll do using this variable
    #We will sort all recipes based on the thumb-up counter. We must use "REVERSE" method because by default sorting starts from the lowest value.
    #Here the badsic code is "@recipes = Recipe.all". But we will use "PAGINATION" gem to list recipes in multiple pages.
    @recipes = Recipe.paginate(page: params[:page], per_page: 1)
  end
  
  def show
    #We want to to show a recipe based on the URL inserted by the user.
    #before action
  end
  
  #The NEW action need CREATE actions
  def new
    @recipe = Recipe.new
  end
  
  #Form submission is handeled by CREATE ACTION
  def create
   #Rails 4 forces us to use STRONG PARAMETERS to white list which submitted parameters should be accepted for security reasons. We'll do it by creating a private method down. 
   @recipe = Recipe.new(recipe_params)
   #We need to insert CHEF ID as we did not define in RECIPE_PARAMS method and it is required inside white list. 
   @recipe.chef = current_user
   if @recipe.save
     #To show a flash message
     flash[:success] = "Your recipe was created successfully!"
     redirect_to recipes_path
   else
     #If it fails, we want it to render the form again
     render :new
   end
   
  end
  
  def edit
    #before action
  end
  
  #Edit action reuires UPDATE ACTION
  def update
    #before action
    #Also in update we need to include the whitelisted fields
    if @recipe.update(recipe_params)
      flash[:success] = "Your recipe was updated successfully"
      #We want to redirect the user to the updated recipe. So we have to provide the object @recipe in the path method
      redirect_to recipe_path(@recipe)
    else
      render :edit
    end
  end
  
  def like
    #We want to know to which recipe we'll send LIKE/DISLILKE. So we'll find it by the sent parameter of ID
    #before action
    #We want to create like for the parameter the user he selected. TRUE/FALSE of "LIKE" in the table can be found by the "LIKE" parameter from URL
    like = Like.create(like: params[:like], chef: current_user, recipe: @recipe)
    if like.valid?
     flash[:success] = "Your selection was successful"
     #We want to redirect the user in the same directory he is currently in
     redirect_to :back
    else
     flash[:danger] = "You can only like/dislike a recipe once"
     redirect_to :back
    end

  end
  
  #PRIVATE METHODS are available only inside this class (Controller Class)
  private
    def recipe_params
      params.require(:recipe).permit(:name, :summary, :description, :picture)
    end
    
    #The order if this method must be her because we will not be able to call REQUIRE_SAME_USER method before calling SET_RECIPES method since it sets @RECIPE varaible which will be used by REQUIRE_SAME_USER method
    #So the order of methods is very important
    def set_recipe
      #We should define this line for SHOW, EDIT, UPDATE, and LIKE, but we will call it from this method using BEFORE_ACTION at the beginning of this controller
      @recipe = Recipe.find(params[:id])
    end
    
    def require_same_user
      if current_user != @recipe.chef
        flash[:danger] = "You can only edit your own recipes"
        redirect_to recipes_path
      end
    end

end