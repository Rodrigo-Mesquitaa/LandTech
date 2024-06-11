class Api::V1::SubmissionsController < ApplicationController
    def create
      @submission = Submission.new(submission_params)
      if @submission.save
        render json: @submission, status: :created
      else
        render json: @submission.errors, status: :unprocessable_entity
      end
    end
  
    private
  
    def submission_params
      params.require(:submission).permit(:name, :email, :mobile_phone, :resume, :job_id)
    end
  end