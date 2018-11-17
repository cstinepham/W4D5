class UsersController < ApplicationController
  before_action :require_log_in, except: [:create, :new]

  def new
    render :new
  end

  def create
    user = User.new(user_params)
    if user.save
      redirect_to user_url(user)
    else
      flash.now[:errors] = user.errors.full_messages
      render :new
    end
  end

  def show
    @user = User.find_by(id: params[:id])
    render :show
  end

  def index
    @users = User.all
    render :index
  end

  # def edit
  #   @user = User.find_by(id: params[:id])
  #   render :edit
  # end
  #
  # def update
  #   user = User.find_by(id: params[:id])
  #
  #   if user.update(user_params)
  #     redirect_to user_url(user)
  #   else
  #     flash.now[:errors] = user.errors.full_messages
  #     render :edit
  #   end
  # end

  private
  def user_params
    params.require(:user).permit(:username, :password)
  end

end
