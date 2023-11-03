class TasksController < ApplicationController

  def index
    @tasks = Task.all.order(created_at: :desc)
    # 終了期限のソート
    if params[:sort_deadline]
      @tasks = @tasks.order(deadline: :desc)
    end
    # タイトル検索
    if params[:task].present?
      #もしパラメータがタイトルとステータス両方だったとき
      if params[:task][:title] && params[:task][:status].present?
        @tasks = @tasks.where("title LIKE ?", "%" + params[:task][:title] + "%" ).
                        where(status: params[:task][:status])
      #もし渡されたパラメータがタイトルのみだったとき（実装途中）
      elsif params[:task][:title]
        @tasks = @tasks.where("title LIKE ?", "%" + params[:task][:title] + "%" )
      #もし渡されたパラメータがステータスのみだったとき
      else params[:task][:status]
        @tasks = @tasks.where(status: params[:task][:status])
      end
    end
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      redirect_to tasks_path, notice: "タスクを作成しました"
    else
      render :new
    end
  end

  def show
    @task = Task.find(params[:id])
  end

  def edit
    @task = Task.find(params[:id]) 
  end

  def update
    @task = Task.find(params[:id])
    if @task.update(task_params)
      redirect_to tasks_path, notice: "タスクを更新しました"
    else
      render :edit
    end
  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    redirect_to tasks_path, notice: "タスクを削除しました"
  end

  private

  def task_params
    params.require(:task).permit(:title, :content, :deadline, :status)
  end
end
