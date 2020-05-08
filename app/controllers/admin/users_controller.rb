class Admin::UsersController < ApplicationController
    before_action :judge_admin
    before_action :set_user, only: [:show, :edit, :update, :destroy]
  
    def index
      @users = User.includes(:tasks)
    end
  
    def show
    end
  
    def new
      @user = User.new
    end
  
    def edit
    end
  
    def create
      @user = User.new(user_params)
      if @user.save
        redirect_to admin_users_path,notice: "ユーザ「#{@user.name}」を登録しました。"
      else
        render :new
      end
    end
  
    def update
        params[:user].delete("password") if params[:user][:password].blank?
        if @user.update(user_params)
          redirect_to admin_user_url(@user),notice: "ユーザー「#{@user.name}」を更新しました。"
        else
          render :new
        end
      end
  

    def destroy
      if @user.destroy
        redirect_to admin_users_url, notice: "ユーザー「#{@user.name}」を削除しました。"
      else
        redirect_to admin_users_url,notice: "逃がしませんよ？ 管理者は１人以上必要です。"
      end
    end
  
    private
  
    def user_params
      params.require(:user).permit(:name, :email, :admin, :password, :password_confirmation)
    end
  
    def set_user
      @user = User.find(params[:id])
    end
  
    def judge_admin
      unless current_user.admin?
        redirect_to tasks_path 
        flash[:notice] = "あなたは管理者ではありません"
      end
    end
  
end