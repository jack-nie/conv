require 'test_helper'

class ExcelsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @excel = excels(:one)
  end

  test "should get index" do
    get excels_url
    assert_response :success
  end

  test "should get new" do
    get new_excel_url
    assert_response :success
  end

  test "should create excel" do
    assert_difference('Excel.count') do
      post excels_url, params: { excel: {  } }
    end

    assert_redirected_to excel_url(Excel.last)
  end

  test "should show excel" do
    get excel_url(@excel)
    assert_response :success
  end

  test "should get edit" do
    get edit_excel_url(@excel)
    assert_response :success
  end

  test "should update excel" do
    patch excel_url(@excel), params: { excel: {  } }
    assert_redirected_to excel_url(@excel)
  end

  test "should destroy excel" do
    assert_difference('Excel.count', -1) do
      delete excel_url(@excel)
    end

    assert_redirected_to excels_url
  end
end
