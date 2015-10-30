class BidsController < ApplicationController
  before_action :convert_price_to_f, only: [:create]
  def new
    @bid = Bid.new
    @product = Product.find_by(id: params[:product_id])
  end

  def create
    @bid = Bid.new(bid_params)

    if @bid.valid_bid?
      @bid.save
      flash[:notice] = "Bid successful"
      redirect_to product_path(@bid.product)
    else
      flash[:warn] = "Unable to process bid, please try again"
      redirect_to :back
    end
  end

  private

  def convert_price_to_f
    params[:bid][:price] = params[:bid][:price].to_f
  end

  def bid_params
    params.require(:bid).permit(:price, :user_id, :product_id)
  end
end