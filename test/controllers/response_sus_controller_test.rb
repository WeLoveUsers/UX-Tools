require 'test_helper'

class ResponseSusControllerTest < ActionDispatch::IntegrationTest
  setup do
    @response_su = response_sus(:one)
  end

  test "should get index" do
    get response_sus_url
    assert_response :success
  end

  test "should get new" do
    get new_response_su_url
    assert_response :success
  end

  test "should create response_su" do
    assert_difference('ResponseSu.count') do
      post response_sus_url, params: { response_su: { Q10: @response_su.Q10, Q1: @response_su.Q1, Q2: @response_su.Q2, Q3: @response_su.Q3, Q4: @response_su.Q4, Q5: @response_su.Q5, Q6: @response_su.Q6, Q7: @response_su.Q7, Q8: @response_su.Q8, Q9: @response_su.Q9, project_id: @response_su.project_id, respondent_id: @response_su.respondent_id } }
    end

    assert_redirected_to response_su_url(ResponseSu.last)
  end

  test "should show response_su" do
    get response_su_url(@response_su)
    assert_response :success
  end

  test "should get edit" do
    get edit_response_su_url(@response_su)
    assert_response :success
  end

  test "should update response_su" do
    patch response_su_url(@response_su), params: { response_su: { Q10: @response_su.Q10, Q1: @response_su.Q1, Q2: @response_su.Q2, Q3: @response_su.Q3, Q4: @response_su.Q4, Q5: @response_su.Q5, Q6: @response_su.Q6, Q7: @response_su.Q7, Q8: @response_su.Q8, Q9: @response_su.Q9, project_id: @response_su.project_id, respondent_id: @response_su.respondent_id } }
    assert_redirected_to response_su_url(@response_su)
  end

  test "should destroy response_su" do
    assert_difference('ResponseSu.count', -1) do
      delete response_su_url(@response_su)
    end

    assert_redirected_to response_sus_url
  end
end
