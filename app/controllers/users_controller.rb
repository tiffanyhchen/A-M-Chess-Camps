class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :check_login, only: [:show, :edit, :update, :destroy]
  authorize_resource

  def index
    # finding all the active owners and paginating that list (will_paginate)
    @users = User.all.paginate(:page => params[:users]).per_page(10)
  end

  def new
    @user = User.new

  end

  def edit
    @user.role = "instructor" if current_user.role?(:instructor)
    @user.role = "admin" if current_user.role?(:admin)
  end

  def create
    @user = User.new(user_params)
    @user.role = "instructor" if current_user.role?(:instructor)
    @user.role = "admin" if current_user.role?(:admin)
    if @user.save
      flash[:notice] = "Successfully added #{@user.username} as a user."
      redirect_to users_url
    else
      render action: 'new'
    end
  end

  def update
    if @user.update_attributes(user_params)
      flash[:notice] = "Successfully updated #{@user.username}."
      redirect_to users_url
    else
      render action: 'edit'
    end
  end

  def destroy
    if @user.destroy
      redirect_to users_url, notice: "Successfully removed #{@user.username} from the A & M Chess Camps system."
    else
      render action: 'show'
    end
  end

  private
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:active, :username, :role, :email, :phone, :password, :password_confirmation)
    end

end
