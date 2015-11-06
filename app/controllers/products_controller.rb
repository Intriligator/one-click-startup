class ProductsController < ApplicationController
  before_action :product_by_id, only: [:show, :edit, :update, :destroy, :pay, :charge, :confirm]
  before_action :require_admin, only: [:pending]

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    @product.assign_attributes(expiration: DateTime.now)

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
    assign_expiration

    if @product.save
      send_notification
      @product.update_attribute(:expiration, DateTime.now + 1.month)
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

  def pay

  end

  def charge
    # Amount in cents
    @amount = @product.highest_bid.price_in_cents

    customer = Stripe::Customer.create(
      :email => params[:stripeEmail],
      :card  => params[:stripeToken]
    )

    charge = Stripe::Charge.create(
      :customer    => customer.id,
      :amount      => @amount,
      :description => 'Rails Stripe customer',
      :currency    => 'usd'
    )

    @product.update_attribute(:paid, true)
    redirect_to confirm_product_path

  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to charge_product_path(@product)
  end

  def confirm
  end

  private

  def product_params
    params.require(:product).permit(:name, :user_id, :approved, :description, :catagory_id)
  end

  def product_by_id
    @product = Product.find_by(id: params[:id])
  end

  def assign_expiration
    date = DateTime.now + 1.minutes
    @product.assign_attributes(expiration: date)
  end

  def send_notification
    notification = Notification.create(
      user_id: @product.user.id,
      content: "Your submission for #{@product.name} has been approved"
    )
  end
end