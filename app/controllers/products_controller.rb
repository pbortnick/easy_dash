class ProductsController < ApplicationController
  
  before_action :set_current_user
  
  def index
    @categories = Category.all
  end

  def show
    @product = Product.find(params[:id])
  end
  
  
  private
  
  def set_current_user
    @current_user = current_user
  end
  
end
