class CategoriesController < ApplicationController
  before_action :set_category, only: [:show]
  before_action :redirect_logged_out, except: [:show]
  
  def show
  end
  
  def new
    @category = Category.new
  end
  
  def create
    @category = Category.new(category_params)
    
    if @category.save
      flash[:notice] = "Category successfully created!"
      redirect_to root_path
    else
      render :new
    end
  end
  
  private
  
    def category_params
      params.require(:category).permit(:name)
    end
    
    def set_category
      @category = Category.find(params[:id])
    end
  
  
end