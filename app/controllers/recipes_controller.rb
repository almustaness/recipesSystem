#The name of the file of this controller is named with undescore. But the class of this controller should be Camel Case.
class RecipesController < ApplicationController
  
  #We define index action here
  def index
    #We want to retrieve data from the database and pass these data to the "INDEX VIEW". We'll do using this variable
    @recipes = Recipe.all
  end
  
  def show
    #We want to to show a recipe based on the URL inserted by the user.
    @recipe = Recipe.find(params[:id])
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
   @recipe.chef = Chef.find(1)
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
    @recipe = Recipe.find(params[:id])
  end
  
  #Edit action reuires UPDATE ACTION
  def update
    @recipe = Recipe.find(params[:id])
    #Also in update we need to include the whitelisted fields
    if @recipe.update(recipe_params)
      flash[:success] = "Your recipe wa updated successfully"
      #We want to redirect the user to the updated recipe. So we have to provide the object @recipe in the path method
      redirect_to recipe_path(@recipe)
    else
      render :edit
    end
  end
  
  #PRIVATE METHODS are available only inside this class (Controller Class)
  private
    def recipe_params
      params.require(:recipe).permit(:name, :summary, :description)
    end
      
  
end