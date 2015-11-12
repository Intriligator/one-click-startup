class LikesController < ApplicationController
  def create
    @like = Like.new(
      user_id: current_user.id,
      product_id: Product.find_by(id: params[:id])
    )

    flash[:warn] = "Unable to save like, please try again" unless @like.save
    redirect_to :back
  end
end