class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  before_action :login_judge, only: [:create, :edit, :update, :destroy, :new, :show, :index ]

  def index
    @tasks = Task.all.order(id: "DESC").page(params[:page]).per(10)
   
    if params[:sort_expired]
      @tasks = Task.all.order(deadline: "DESC").page(params[:page]).per(10)
    
    end
    if params[:sort_rank]
      @tasks = Task.all.order(status: "DESC").page(params[:page]).per(10)
  
    end
    if params[:search].present?
      if params[:task_name].present? and params[:status].present?
        @tasks = @tasks.title_search params[:task_name]
        @tasks = @tasks.status_search params[:status]
      elsif params[:task_name].present?
        @tasks = @tasks.title_search params[:task_name]
      elsif params[:status].present?
        @tasks = @tasks.status_search params[:status]
      end
    end
  end

  def show
  end
 
  def new
    @task = Task.new
  end

  def edit
  end

  def create
    @task = Task.new(task_params)
    respond_to do |format|
      if @task.save
        format.html { redirect_to @task, notice: 'タスクを作成しました' }
        format.json { render :show, status: :created, location: @task }
      else
        format.html { render :new }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to @task, notice: 'タスクを変更しました' }
        format.json { render :show, status: :ok, location: @task }
      else
        format.html { render :edit }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @task.destroy
    respond_to do |format|
      format.html { redirect_to tasks_url, notice: 'タスクを削除しました' }
      format.json { head :no_content }
    end
  end
  private

  def set_task
    @task = Task.find(params[:id])
    unless current_user == @task.user
      redirect_to tasks_path, notice: "他人の投稿はいじれません"
    end
  end


  def task_params
    params.require(:task).permit(:task_name, :description, :deadline, :status, :priority)
  end

  def login_judge
    unless logged_in?
      redirect_to new_session_path
    end
  end
end