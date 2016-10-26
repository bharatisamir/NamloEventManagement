require 'test_helper'

class QuotationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @quotation = quotations(:one)
  end

  test "should get index" do
    get quotations_url
    assert_response :success
  end

  test "should get new" do
    get new_quotation_url
    assert_response :success
  end

  test "should create quotation" do
    assert_difference('Quotation.count') do
      post quotations_url, params: { quotation: {comments: @quotation.comments, event_id: @quotation.event_id, rfq_delivery_method: @quotation.frq_delivery_method, rfq_closing_date: @quotation.rfq_closing_date, rfq_contact: @quotation.rfq_contact, rfq_issue_date: @quotation.rfq_issue_date, services_requested: @quotation.services_requested } }
    end

    assert_redirected_to quotation_url(Quotation.last)
  end

  test "should show quotation" do
    get quotation_url(@quotation)
    assert_response :success
  end

  test "should get edit" do
    get edit_quotation_url(@quotation)
    assert_response :success
  end

  test "should update quotation" do
    patch quotation_url(@quotation), params: { quotation: {comments: @quotation.comments, event_id: @quotation.event_id, rfq_delivery_method: @quotation.frq_delivery_method, rfq_closing_date: @quotation.rfq_closing_date, rfq_contact: @quotation.rfq_contact, rfq_issue_date: @quotation.rfq_issue_date, services_requested: @quotation.services_requested } }
    assert_redirected_to quotation_url(@quotation)
  end

  test "should destroy quotation" do
    assert_difference('Quotation.count', -1) do
      delete quotation_url(@quotation)
    end

    assert_redirected_to quotations_url
  end
end
