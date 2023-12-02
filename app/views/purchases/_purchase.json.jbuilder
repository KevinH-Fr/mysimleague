json.extract! purchase, :id, :status, :article_id, :user_id, :stripe_ref, :created_at, :updated_at
json.url purchase_url(purchase, format: :json)
