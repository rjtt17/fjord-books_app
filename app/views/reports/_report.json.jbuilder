json.extract! report, :id, :title, :description, :created_at, :updated_at
json.url report_url(report, format: :json)
