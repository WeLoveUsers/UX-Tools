require 'test_helper'

class ResponseAttrakDiffsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @response_attrak_diff = response_attrak_diffs(:one)
  end

  test "should get index" do
    get response_attrak_diffs_url
    assert_response :success
  end

  test "should get new" do
    get new_response_attrak_diff_url
    assert_response :success
  end

  test "should create response_attrak_diff" do
    assert_difference('ResponseAttrakDiff.count') do
      post response_attrak_diffs_url, params: { response_attrak_diff: { ATT1: @response_attrak_diff.ATT1, ATT2: @response_attrak_diff.ATT2, ATT3: @response_attrak_diff.ATT3, ATT4: @response_attrak_diff.ATT4, ATT5: @response_attrak_diff.ATT5, ATT6: @response_attrak_diff.ATT6, ATT7: @response_attrak_diff.ATT7, QHI1: @response_attrak_diff.QHI1, QHI2: @response_attrak_diff.QHI2, QHI3: @response_attrak_diff.QHI3, QHI4: @response_attrak_diff.QHI4, QHI5: @response_attrak_diff.QHI5, QHI6: @response_attrak_diff.QHI6, QHI7: @response_attrak_diff.QHI7, QHS1: @response_attrak_diff.QHS1, QHS2: @response_attrak_diff.QHS2, QHS3: @response_attrak_diff.QHS3, QHS4: @response_attrak_diff.QHS4, QHS5: @response_attrak_diff.QHS5, QHS6: @response_attrak_diff.QHS6, QHS7: @response_attrak_diff.QHS7, QP1: @response_attrak_diff.QP1, QP2: @response_attrak_diff.QP2, QP3: @response_attrak_diff.QP3, QP4: @response_attrak_diff.QP4, QP5: @response_attrak_diff.QP5, QP6: @response_attrak_diff.QP6, QP7: @response_attrak_diff.QP7, project_id: @response_attrak_diff.project_id, respondent_id: @response_attrak_diff.respondent_id } }
    end

    assert_redirected_to response_attrak_diff_url(ResponseAttrakDiff.last)
  end

  test "should show response_attrak_diff" do
    get response_attrak_diff_url(@response_attrak_diff)
    assert_response :success
  end

  test "should get edit" do
    get edit_response_attrak_diff_url(@response_attrak_diff)
    assert_response :success
  end

  test "should update response_attrak_diff" do
    patch response_attrak_diff_url(@response_attrak_diff), params: { response_attrak_diff: { ATT1: @response_attrak_diff.ATT1, ATT2: @response_attrak_diff.ATT2, ATT3: @response_attrak_diff.ATT3, ATT4: @response_attrak_diff.ATT4, ATT5: @response_attrak_diff.ATT5, ATT6: @response_attrak_diff.ATT6, ATT7: @response_attrak_diff.ATT7, QHI1: @response_attrak_diff.QHI1, QHI2: @response_attrak_diff.QHI2, QHI3: @response_attrak_diff.QHI3, QHI4: @response_attrak_diff.QHI4, QHI5: @response_attrak_diff.QHI5, QHI6: @response_attrak_diff.QHI6, QHI7: @response_attrak_diff.QHI7, QHS1: @response_attrak_diff.QHS1, QHS2: @response_attrak_diff.QHS2, QHS3: @response_attrak_diff.QHS3, QHS4: @response_attrak_diff.QHS4, QHS5: @response_attrak_diff.QHS5, QHS6: @response_attrak_diff.QHS6, QHS7: @response_attrak_diff.QHS7, QP1: @response_attrak_diff.QP1, QP2: @response_attrak_diff.QP2, QP3: @response_attrak_diff.QP3, QP4: @response_attrak_diff.QP4, QP5: @response_attrak_diff.QP5, QP6: @response_attrak_diff.QP6, QP7: @response_attrak_diff.QP7, project_id: @response_attrak_diff.project_id, respondent_id: @response_attrak_diff.respondent_id } }
    assert_redirected_to response_attrak_diff_url(@response_attrak_diff)
  end

  test "should destroy response_attrak_diff" do
    assert_difference('ResponseAttrakDiff.count', -1) do
      delete response_attrak_diff_url(@response_attrak_diff)
    end

    assert_redirected_to response_attrak_diffs_url
  end
end
