class UsersController < ApplicationController
    before_action :set_user, only: [:show, :edit, :update, :destroy] 
    before_action :login_judge, only: [:new]
  
    def new
      @user = User.new
    end
  
    def show
      @user = User.find(params[:id])
    end
  
    def create
      @user = User.new(user_params)
      if @user.save
        session[:user_id] = @user.id  
        redirect_to user_path(@user.id)
      else
        render :new
      end
    end
  
    def edit
    end
  
    def update
      if @user.update(user_params)
        flash[:notice] = "ユーザー情報を編集しました"
        redirect_to user_path(@user.id)
      else
        render("users/edit")
      end
    end
  
    private
    def user_params
        params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
    def set_user
      @user = User.find(params[:id])
    end
    def login_judge
        if logged_in?
          flash[:notice] = "ログイン中は新規作成できません"
          redirect_to tasks_path
        end
    end
  end