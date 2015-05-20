class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :get_user, except: [:index, :new]

  def index
    @users = User.all
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user)
    else
      render 'edit'
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :date_of_birth, address_attributes: [ :id, :address, :city, :postal_code ])
  end

  def get_user
    @user = User.find(params[:id])
  end
end
