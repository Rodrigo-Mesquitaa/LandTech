class Api::V1::RecruitersController < ApplicationController
    before_action :authenticate_user!, except: [:index, :show]
  
    def index
      @recruiters = Recruiter.all
      render json: @recruiters
    end
  
    def show
      @recruiter = Recruiter.find(params[:id])
      render json: @recruiter
    end
  
    def create
      @recruiter = Recruiter.new(recruiter_params)
      if @recruiter.save
        render json: @recruiter, status: :created
      else
        render json: @recruiter.errors, status: :unprocessable_entity
      end
    end
  
    def update
      @recruiter = Recruiter.find(params[:id])
      if @recruiter.update(recruiter_params)
        render json: @recruiter
      else
        render json: @recruiter.errors, status: :unprocessable_entity
      end
    end
  
    def destroy
      @recruiter = Recruiter.find(params[:id])
      @recruiter.destroy
      head :no_content
    end
  
    private
  
    def recruiter_params
      params.require(:recruiter).permit(:name, :email, :password)
    end
  end