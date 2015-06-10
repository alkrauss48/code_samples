require 'test_helper'

class BreakdownsControllerTest < ActionController::TestCase
  setup do
    @breakdown = breakdowns(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:breakdowns)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create breakdown" do
    assert_difference('Breakdown.count') do
      post :create, breakdown: { amount: @breakdown.amount, late_payment: @breakdown.late_payment, missed_payment: @breakdown.missed_payment, pay_date: @breakdown.pay_date }
    end

    assert_redirected_to breakdown_path(assigns(:breakdown))
  end

  test "should show breakdown" do
    get :show, id: @breakdown
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @breakdown
    assert_response :success
  end

  test "should update breakdown" do
    put :update, id: @breakdown, breakdown: { amount: @breakdown.amount, late_payment: @breakdown.late_payment, missed_payment: @breakdown.missed_payment, pay_date: @breakdown.pay_date }
    assert_redirected_to breakdown_path(assigns(:breakdown))
  end

  test "should destroy breakdown" do
    assert_difference('Breakdown.count', -1) do
      delete :destroy, id: @breakdown
    end

    assert_redirected_to breakdowns_path
  end
end
