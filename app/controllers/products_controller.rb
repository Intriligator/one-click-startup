class ProductsController < ApplicationController
  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to home_path
    else
      flash[:warn] = "Unable to save product submission, please try again"
      redirect_to :back
    end
  end

  private

  def product_params
    params.require(:product).permit(:name, :user_id, :description, :catagory_id)
  end
end