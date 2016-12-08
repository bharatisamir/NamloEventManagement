require 'test_helper'

class EventOrdersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @event_order = event_orders(:one)
  end

  test "should get index" do
    get event_orders_url
    assert_response :success
  end

  test "should get new" do
    get new_event_order_url
    assert_response :success
  end

  test "should create event_order" do
    assert_difference('EventOrder.count') do
      post event_orders_url, params: { event_order: { event_id: @event_order.event_id, order_date: @event_order.order_date, primary_onsite_contact: @event_order.primary_onsite_contact, primary_phone: @event_order.primary_phone, secondary_onsite_contact: @event_order.secondary_onsite_contact, secondary_phone: @event_order.secondary_phone } }
    end

    assert_redirected_to event_order_url(EventOrder.last)
  end

  test "should show event_order" do
    get event_order_url(@event_order)
    assert_response :success
  end

  test "should get edit" do
    get edit_event_order_url(@event_order)
    assert_response :success
  end

  test "should update event_order" do
    patch event_order_url(@event_order), params: { event_order: { event_id: @event_order.event_id, order_date: @event_order.order_date, primary_onsite_contact: @event_order.primary_onsite_contact, primary_phone: @event_order.primary_phone, secondary_onsite_contact: @event_order.secondary_onsite_contact, secondary_phone: @event_order.secondary_phone } }
    assert_redirected_to event_order_url(@event_order)
  end

  test "should destroy event_order" do
    assert_difference('EventOrder.count', -1) do
      delete event_order_url(@event_order)
    end

    assert_redirected_to event_orders_url
  end
end
