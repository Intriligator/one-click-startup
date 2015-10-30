class ProductsController < ApplicationController
  before_action :product_by_id, only: [:show, :edit, :update]
  before_action :require_admin, only: [:pending]

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

  def show
  end

  def edit
  end

  def update
    @product.assign_attributes(product_params)
    if @product.save
      redirect_to home_path
    else
      flash[:warn] = "Unable to update product, please try again"
      redirect_to :back
    end
  end

  def pending
    @products = Product.where(approved: false)
  end

  private

  def product_params
    params.require(:product).permit(:name, :user_id, :approved, :description, :catagory_id)
  end

  def product_by_id
    @product = Product.find_by(id: params[:id])
  end
end