json.extract! question, :id, :user_id, :secret, :text, :mcq, :created_at, :updated_at
json.url question_url(question, format: :json)
