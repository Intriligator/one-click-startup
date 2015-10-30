class ProductsController < ApplicationController
  before_action :product_by_id, only: [:show, :edit, :update, :destroy]
  before_action :require_admin, only: [:pending]

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    assign_expiration

    if @product.save

      #placeholder image - will erase this block
        @image = Image.create(url: "http://www.connexionsweb.com/wp-content/uploads/2015/03/businessLogo.png", product_id: @product.id)
      #----

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
      send_notification
      redirect_to home_path
    else
      flash[:warn] = "Unable to update product, please try again"
      redirect_to :back
    end
  end

  def destroy
    if @product.delete
      flash[:notice] = "Product Deleted"
      redirect_to home_path
    else
      flash[:warn] = "Unable to delete product, please try again"
      redirect_to :back
    end
  end

  def pending
    @products = Product.pending
  end

  private

  def product_params
    params.require(:product).permit(:name, :user_id, :approved, :description, :catagory_id)
  end

  def product_by_id
    @product = Product.find_by(id: params[:id])
  end

  def assign_expiration
    date = DateTime.now >> 1
    @product.assign_attributes(expiration: date)
  end

  def send_notification
    notification = Notification.create(
      user_id: @product.user.id,
      content: "Your submission for #{@product.name} has been approved"
    )
  end
end