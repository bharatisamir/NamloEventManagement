require 'test_helper'

class InvitationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @invitation = invitations(:one)
  end

  test "should get index" do
    get invitations_url
    assert_response :success
  end

  test "should get new" do
    get new_invitation_url
    assert_response :success
  end

  test "should create invitation" do
    assert_difference('invitation.count') do
      post invitations_url, params: { invitation: { bride_tag_line: @invitation.bride_tag_line, closing_tag_line: @invitation.closing_tag_line, event_id: @invitation.event_id, event_tag_line: @invitation.event_tag_line, gift_tag_line: @invitation.gift_tag_line, groom_tag_line: @invitation.groom_tag_line, mid_tag_line: @invitation.mid_tag_line, opening_tag_line: @invitation.opening_tag_line } }
    end

    assert_redirected_to invitation_url(Invitation.last)
  end

  test "should show invitation" do
    get invitation_url(@invitation)
    assert_response :success
  end

  test "should get edit" do
    get edit_invitation_url(@invitation)
    assert_response :success
  end

  test "should update invitation" do
    patch invitation_url(@invitation), params: { invitation: { bride_tag_line: @invitation.bride_tag_line, closing_tag_line: @invitation.closing_tag_line, event_id: @invitation.event_id, event_tag_line: @invitation.event_tag_line, gift_tag_line: @invitation.gift_tag_line, groom_tag_line: @invitation.groom_tag_line, mid_tag_line: @invitation.mid_tag_line, opening_tag_line: @invitation.opening_tag_line } }
    assert_redirected_to invitation_url(@invitation)
  end

  test "should destroy invitation" do
    assert_difference('invitation.count', -1) do
      delete invitation_url(@invitation)
    end

    assert_redirected_to invitations_url
  end
end
