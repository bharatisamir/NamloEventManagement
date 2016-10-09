require 'test_helper'

class PeerReviewsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @peer_review = peer_reviews(:one)
  end

  test "should get index" do
    get peer_reviews_url
    assert_response :success
  end

  test "should get new" do
    get new_peer_review_url
    assert_response :success
  end

  test "should create peer_review" do
    assert_difference('PeerReview.count') do
      post peer_reviews_url, params: { peer_review: { comments: @peer_review.comments, communication_score: @peer_review.communication_score, cooperation_score: @peer_review.cooperation_score, expertise_score: @peer_review.expertise_score, organization_score: @peer_review.organization_score, people_skills_score: @peer_review.people_skills_score, professionalism_score: @peer_review.professionalism_score, reviewer_id: @peer_review.reviewer_id, service_score: @peer_review.service_score, serviceprovider_id: @peer_review.serviceprovider_id, time_management_score: @peer_review.time_management_score } }
    end

    assert_redirected_to peer_review_url(PeerReview.last)
  end

  test "should show peer_review" do
    get peer_review_url(@peer_review)
    assert_response :success
  end

  test "should get edit" do
    get edit_peer_review_url(@peer_review)
    assert_response :success
  end

  test "should update peer_review" do
    patch peer_review_url(@peer_review), params: { peer_review: { comments: @peer_review.comments, communication_score: @peer_review.communication_score, cooperation_score: @peer_review.cooperation_score, expertise_score: @peer_review.expertise_score, organization_score: @peer_review.organization_score, people_skills_score: @peer_review.people_skills_score, professionalism_score: @peer_review.professionalism_score, reviewer_id: @peer_review.reviewer_id, service_score: @peer_review.service_score, serviceprovider_id: @peer_review.serviceprovider_id, time_management_score: @peer_review.time_management_score } }
    assert_redirected_to peer_review_url(@peer_review)
  end

  test "should destroy peer_review" do
    assert_difference('PeerReview.count', -1) do
      delete peer_review_url(@peer_review)
    end

    assert_redirected_to peer_reviews_url
  end
end
