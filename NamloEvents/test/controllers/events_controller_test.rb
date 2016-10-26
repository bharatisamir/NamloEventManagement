require 'test_helper'

class EventsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @event = events(:one)
  end

  test "should get index" do
    get events_url
    assert_response :success
  end

  test "should get new" do
    get new_event_url
    assert_response :success
  end

  test "should create event" do
    assert_difference('Event.count') do
      post events_url, params: { event: { city: @event.city, comments: @event.comments, country_region: @event.country_region, event_contact: @event.event_contact, event_date: @event.event_date, event_end_time: @event.event_end_time, event_name: @event.event_name, event_start_time: @event.event_start_time, host_id: @event.host_id, publish_on_marketplace: @event.publish_on_marketplace, state_province: @event.state_province, street_address: @event.street_address, zip_postal_code: @event.zip_postal_code } }
    end

    assert_redirected_to event_url(Event.last)
  end

  test "should show event" do
    get event_url(@event)
    assert_response :success
  end

  test "should get edit" do
    get edit_event_url(@event)
    assert_response :success
  end

  test "should update event" do
    patch event_url(@event), params: { event: { city: @event.city, comments: @event.comments, country_region: @event.country_region, event_contact: @event.event_contact, event_date: @event.event_date, event_end_time: @event.event_end_time, event_name: @event.event_name, event_start_time: @event.event_start_time, host_id: @event.host_id, publish_on_marketplace: @event.publish_on_marketplace, state_province: @event.state_province, street_address: @event.street_address, zip_postal_code: @event.zip_postal_code } }
    assert_redirected_to event_url(@event)
  end

  test "should destroy event" do
    assert_difference('Event.count', -1) do
      delete event_url(@event)
    end

    assert_redirected_to events_url
  end
end
