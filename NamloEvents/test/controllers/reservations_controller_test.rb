require 'test_helper'

class ReservationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @reservation = reservations(:one)
  end

  test "should get index" do
    get reservations_url
    assert_response :success
  end

  test "should get new" do
    get new_reservation_url
    assert_response :success
  end

  test "should create reservation" do
    assert_difference('Reservation.count') do
      post reservations_url, params: { reservation: { attending_event: @reservation.attending_event, boolean: @reservation.boolean, complete_address: @reservation.complete_address, email: @reservation.email, event_id: @reservation.event_id, first_name: @reservation.first_name, food_allergies: @reservation.food_allergies, food_choice: @reservation.food_choice, kids_meal_required: @reservation.kids_meal_required, last_name: @reservation.last_name, need_paper_invitation: @reservation.need_paper_invitation, primary_phone: @reservation.primary_phone, special_notes: @reservation.special_notes, total_attending: @reservation.total_attending } }
    end

    assert_redirected_to reservation_url(Reservation.last)
  end

  test "should show reservation" do
    get reservation_url(@reservation)
    assert_response :success
  end

  test "should get edit" do
    get edit_reservation_url(@reservation)
    assert_response :success
  end

  test "should update reservation" do
    patch reservation_url(@reservation), params: { reservation: { attending_event: @reservation.attending_event, boolean: @reservation.boolean, complete_address: @reservation.complete_address, email: @reservation.email, event_id: @reservation.event_id, first_name: @reservation.first_name, food_allergies: @reservation.food_allergies, food_choice: @reservation.food_choice, kids_meal_required: @reservation.kids_meal_required, last_name: @reservation.last_name, need_paper_invitation: @reservation.need_paper_invitation, primary_phone: @reservation.primary_phone, special_notes: @reservation.special_notes, total_attending: @reservation.total_attending } }
    assert_redirected_to reservation_url(@reservation)
  end

  test "should destroy reservation" do
    assert_difference('Reservation.count', -1) do
      delete reservation_url(@reservation)
    end

    assert_redirected_to reservations_url
  end
end
