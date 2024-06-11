class Api::V1::JobsController < ApplicationController
    before_action :authenticate_user!, except: [:index, :show]
  
    def index
      @jobs = Job.where(status: 'active').page(params[:page]).per(10)
      render json: @jobs
    end
  
    def show
      @job = Job.find(params[:id])
      render json: @job
    end
  
    def create
      @job = current_user.jobs.build(job_params)
      if @job.save
        render json: @job, status: :created
      else
        render json: @job.errors, status: :unprocessable_entity
      end
    end
  
    def update
      @job = Job.find(params[:id])
      if @job.update(job_params)
        render json: @job
      else
        render json: @job.errors, status: :unprocessable_entity
      end
    end
  
    def destroy
      @job = Job.find(params[:id])
      @job.destroy
      head :no_content
    end
  
    private
  
    def job_params
      params.require(:job).permit(:title, :description, :start_date, :end_date, :status, :skills)
    end
  end
  