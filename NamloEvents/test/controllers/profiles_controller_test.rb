require 'test_helper'

class ProfilesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @profile = profiles(:one)
  end

  test "should get index" do
    get profiles_url
    assert_response :success
  end

  test "should get new" do
    get new_profile_url
    assert_response :success
  end

  test "should create profile" do
    assert_difference('Profile.count') do
      post profiles_url, params: { profile: { cell_phone: @profile.cell_phone, city: @profile.city, country_region: @profile.country_region, home_phone: @profile.home_phone, state_province: @profile.state_province, street_address: @profile.street_address, user_id: @profile.user_id, zip_postal_code: @profile.zip_postal_code } }
    end

    assert_redirected_to profile_url(Profile.last)
  end

  test "should show profile" do
    get profile_url(@profile)
    assert_response :success
  end

  test "should get edit" do
    get edit_profile_url(@profile)
    assert_response :success
  end

  test "should update profile" do
    patch profile_url(@profile), params: { profile: { cell_phone: @profile.cell_phone, city: @profile.city, country_region: @profile.country_region, home_phone: @profile.home_phone, state_province: @profile.state_province, street_address: @profile.street_address, user_id: @profile.user_id, zip_postal_code: @profile.zip_postal_code } }
    assert_redirected_to profile_url(@profile)
  end

  test "should destroy profile" do
    assert_difference('Profile.count', -1) do
      delete profile_url(@profile)
    end

    assert_redirected_to profiles_url
  end
end
