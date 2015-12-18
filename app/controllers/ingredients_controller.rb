class IngredientsController < ApplicationController
  before_action :require_user, except:[:show]
  def new
    @ingredient = Ingredient.new
  end
  
  def create
    @ingredient = Ingredient.new(ing_params)
    if @ingredient.save
      flash[:success] = "You have created an ingredient successfully"
      redirect_to recipes_path
    else
      render 'new'
    end
  end
  
  def show
    @ingredient = Ingredient.find(params[:id])
    #This is for pagination
    @recipes = @ingredient.recipes.paginate(page: params[:page], per_page: 1)
  end
  
  private
   def ing_params
     params.require(:ingredient).permit(:name)
   end
end