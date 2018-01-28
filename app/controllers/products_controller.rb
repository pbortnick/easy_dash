class ProductsController < ApplicationController

  before_action :set_current_user

  def index
    @categories = Category.all
    @subscriptions = Subscription.all
  end

  def show
    @product = Product.find(params[:id])
  end


  private

  def set_current_user
    @current_user = current_user
  end

end
