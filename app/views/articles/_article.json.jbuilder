json.extract! article, :id, :titre, :content, :created_at, :updated_at
json.url article_url(article, format: :json)
