require 'test_helper'

class EventOrderDetailsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @event_order_detail = event_order_details(:one)
  end

  test "should get index" do
    get event_order_details_url
    assert_response :success
  end

  test "should get new" do
    get new_event_order_detail_url
    assert_response :success
  end

  test "should create event_order_detail" do
    assert_difference('EventOrderDetail.count') do
      post event_order_details_url, params: { event_order_detail: { event_order_id: @event_order_detail.event_order_id, function: @event_order_detail.function, service_date: @event_order_detail.service_date, service_end_time: @event_order_detail.service_end_time, service_id: @event_order_detail.service_id, service_location: @event_order_detail.service_location, service_provider_id: @event_order_detail.service_provider_id, service_setup_requirements: @event_order_detail.service_setup_requirements, service_start_time: @event_order_detail.service_start_time } }
    end

    assert_redirected_to event_order_detail_url(EventOrderDetail.last)
  end

  test "should show event_order_detail" do
    get event_order_detail_url(@event_order_detail)
    assert_response :success
  end

  test "should get edit" do
    get edit_event_order_detail_url(@event_order_detail)
    assert_response :success
  end

  test "should update event_order_detail" do
    patch event_order_detail_url(@event_order_detail), params: { event_order_detail: { event_order_id: @event_order_detail.event_order_id, function: @event_order_detail.function, service_date: @event_order_detail.service_date, service_end_time: @event_order_detail.service_end_time, service_id: @event_order_detail.service_id, service_location: @event_order_detail.service_location, service_provider_id: @event_order_detail.service_provider_id, service_setup_requirements: @event_order_detail.service_setup_requirements, service_start_time: @event_order_detail.service_start_time } }
    assert_redirected_to event_order_detail_url(@event_order_detail)
  end

  test "should destroy event_order_detail" do
    assert_difference('EventOrderDetail.count', -1) do
      delete event_order_detail_url(@event_order_detail)
    end

    assert_redirected_to event_order_details_url
  end
end
