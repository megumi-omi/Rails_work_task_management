class Admin::UsersController < ApplicationController
   before_action :user_check

  def user_check
    if current_user.admin
    else 
      redirect_to tasks_path
      flash[:danger] = "管理者以外アクセスできません"
    end
  end

  def index
    @users = User.all.includes(:tasks)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = "一般ユーザを作成しました"
      redirect_to admin_users_path
    else
      flash[:danger] = "ユーザ作成に失敗しました"
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
    @tasks = @user.tasks
  end

  def update
    @user = User.find(params[:id])
    #名前だけ変更
    @user.update_attribute(:name, params[:user][:name])
    #emailだけ変更
    @user.update_attribute(:email, params[:user][:email])
    @user.update_attribute(:admin, params[:user][:admin])
    if @user.save
      flash[:notice] = "ユーザ情報を更新しました"
      redirect_to admin_users_path
    else
      binding.irb
      render :edit
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    flash[:notice] = "ユーザを削除しました"
    redirect_to admin_users_path
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :admin, :password, :password_confirmation)
  end
end
