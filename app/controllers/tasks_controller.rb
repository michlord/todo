class TasksController < ApplicationController
  def index
    @tasks = Task.all
    respond_to do |format|
      format.html { render html: @tasks }
      format.json { render json: @tasks }
    end
  end
  def add
    new_task = Task.new(task_params)
    new_task.save()
    @tasks = Task.all
    respond_to do |format|
      format.html { render html: @tasks }
      format.json { render json: @tasks }
    end
  end
  def delete
    Task.find(params[:id]).destroy()
    @tasks = Task.all
    respond_to do |format|
      format.html { render html: @tasks }
      format.json { render json: @tasks }
    end
  end
  private
  def task_params
      params.require(:task).permit(:body, :done)
  end
end
