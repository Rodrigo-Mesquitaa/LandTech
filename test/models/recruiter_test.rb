require 'test_helper'

class RecruiterTest < ActiveSupport::TestCase
  test "should not save recruiter without name" do
    recruiter = Recruiter.new
    assert_not recruiter.save, "Saved the recruiter without a name"
  end
end

# test/controllers/api/v1/recruiters_controller_test.rb
require 'test_helper'

class Api::V1::RecruitersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @recruiter = recruiters(:one)
  end

  test "should get index" do
    get api_v1_recruiters_url, as: :json
    assert_response :success
  end

  test "should create recruiter" do
    assert_difference('Recruiter.count') do
      post api_v1_recruiters_url, params: { recruiter: { name: 'John', email: 'john@example.com', password: 'password' } }, as: :json
    end
    assert_response 201
  end

  test "should show recruiter" do
    get api_v1_recruiter_url(@recruiter), as: :json
    assert_response :success
  end

  test "should update recruiter" do
    patch api_v1_recruiter_url(@recruiter), params: { recruiter: { name: 'John Updated' } }, as: :json
    assert_response 200
  end

  test "should destroy recruiter" do
    assert_difference('Recruiter.count', -1) do
      delete api_v1_recruiter_url(@recruiter), as: :json
    end
    assert_response 204
  end
end