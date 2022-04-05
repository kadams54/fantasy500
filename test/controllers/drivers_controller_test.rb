require 'test_helper'

class DriversControllerTest < ActionDispatch::IntegrationTest
  setup do
    @driver = create(:driver)
    @admin = create(:user, :admin, :active)
    @user = create(:user, :active)
  end

  test "should get index" do
    get drivers_url
    assert_response :success
  end

  test "should get new for admin" do
    log_in_as @admin, password: @admin.password
    get new_driver_url
    assert_response :success
  end

  test "should forbid new for non-admin" do
    log_in_as @user, password: @user.password
    get new_driver_url
    assert_response :forbidden
  end

  test "should create driver for admin" do
    log_in_as @admin, password: @admin.password
    assert_difference('Driver.count') do
      post drivers_url, params: {driver: attributes_for(:driver)}
    end
    assert_redirected_to driver_url(Driver.last)
  end

  test "should forbid create for non-admin" do
    log_in_as @user, password: @user.password
    assert_no_difference('Driver.count') do
      post drivers_url, params: {driver: attributes_for(:driver)}
    end
    assert_response :forbidden
  end

  test "should show driver" do
    get driver_url(@driver)
    assert_response :success
  end

  test "should get edit for admin" do
    log_in_as @admin, password: @admin.password
    get edit_driver_url(@driver)
    assert_response :success
  end

  test "should forbid edit for non-admin" do
    log_in_as @user, password: @user.password
    get edit_driver_url(@driver)
    assert_response :forbidden
  end

  test "should update driver for admin" do
    log_in_as @admin, password: @admin.password
    patch driver_url(@driver), params: {driver: {name: Faker::Name.name}}
    assert_redirected_to driver_url(@driver)
  end

  test "should forbid update for non-admin" do
    log_in_as @user, password: @user.password
    patch driver_url(@driver), params: {driver: {name: Faker::Name.name}}
    assert_response :forbidden
  end

  test "should destroy driver for admin" do
    log_in_as @admin, password: @admin.password
    assert_difference('Driver.count', -1) do
      delete driver_url(@driver)
    end
    assert_redirected_to drivers_url
  end

  test "should forbid destroy for non-admin" do
    log_in_as @user, password: @user.password
    assert_no_difference('Driver.count') do
      delete driver_url(@driver)
    end
    assert_response :forbidden
  end
end
