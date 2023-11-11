class SessionsController < ApplicationController
  skip_before_action :login_required, only: [:new, :create,:show]

  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      if user.admin?
        redirect_to admin_users_path
      else
        redirect_to user_path(user.id)
      end
    else
      flash[:danger] = 'ログインに失敗しました'
      render :new
    end
  end

  def destroy
    session.delete(:user_id)
    flash[:notice]='ログアウトしました'
    redirect_to new_session_path
  end

end
