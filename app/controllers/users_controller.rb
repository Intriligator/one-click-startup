class UsersController < ApplicationController
  before_action :require_current_user, except: [:new, :create]
  before_action :user_by_id, only: [:home, :show, :edit, :update, :destroy, :pending, :inbox, :notifications]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to home_path
    else
      flash[:warn] = "Unable to create new user. Please try again."
      redirect_to new_user_path
    end
  end

  def show
  end

  def edit
  end

  def update
  end

  def destroy
  end

  def home
    @products = Product.all_active
  end

  def pending
    @products = current_user.pending_products
  end

  def inbox
  end

  def notifications
    current_user.read_notifications
    @notifications = current_user.notifications.order(created_at: :desc)
  end

  def won_products
    @products = current_user.won_products
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :password, :email, :bio, :location, :occupation)
  end

  def user_by_id
    @user = User.find_by(id: params[:id])
  end
end