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
      unless params[:product][:file]
        #placeholder image - will erase this block
          @image = Image.create(url: "http://www.connexionsweb.com/wp-content/uploads/2015/03/businessLogo.png", product_id: @product.id)
        #----
      else
        params[:product][:file].each do |file|
          obj = S3_BUCKET.object(file.original_filename)

          obj.upload_file(file.tempfile, acl:'public-read')

          @image = Image.new(url: obj.public_url, product_id: @product.id)

          unless @image.save
            flash[:warn] = "There was a problem uploading your image(s), please try again"
            redirect_to :back
          end
        end
      end

      redirect_to home_path
    else
      flash[:warn] = "Unable to save product submission, please try again"
      redirect_to :back
    end
  end

  def show
    create_view
  end

  def edit
  end

  def update
    @product.assign_attributes(product_params)
    assign_expiration

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
    set_up_payment

  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to charge_product_path(@product)
  end

  def confirm
  end

  private

  def product_params
    params.require(:product).permit(:name, :user_id, :approved, :description, :catagory_id, :tagline)
  end

  def product_by_id
    @product = Product.find_by(id: params[:id])
  end

  def assign_expiration
    date = DateTime.now + 1.weeks
    @product.assign_attributes(expiration: date)
  end

  def send_notification
    notification = Notification.create(
      user_id: @product.user.id,
      content: "Your submission for #{@product.name} has been approved"
    )
  end

  def set_up_payment
    payment = Payment.create(
      user_id: @product.user.id,
      buyer_id: current_user.id,
      price: @product.highest_bid.price,
      hold_date: DateTime.now + 2.weeks
    )
  end

  def create_view
    unless @product.user == current_user
      current_user ? current_user_id = current_user.id : current_user_id = nil
      View.create(
        user_id: current_user_id,
        product_id: @product.id
      )
    end
  end

end