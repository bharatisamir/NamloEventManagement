json.extract! review, :id, :reviewer_id, :rating_score, :comments, :serviceprovider_id, :created_at, :updated_at
json.url review_url(review, format: :json)