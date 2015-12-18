class StylesController < ApplicationController
  before_action :require_user, except: [:show]
  def new
    @style = Style.new
  end
  
  def create
    @style = Style.new(style_params)
    if @style.save
      flash[:success] = "You have created a style successfully"
      redirect_to recipes_path
    else
    render 'new'
    end
  end
  
  def show
    @style = Style.find(params[:id])
    #This is for pagination
    @recipes = @style.recipes.paginate(page: params[:page], per_page: 1)
  end
  
  private
   def style_params
    params.require(:style).permit(:name)
   end
end