json.array!(@projects) do |project|
  json.extract! project, :id, :github_id, :name, :slug, :description, :user_id
  json.url project_url(project, format: :json)
end
