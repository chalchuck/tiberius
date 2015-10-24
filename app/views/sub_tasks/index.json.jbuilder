json.array!(@sub_tasks) do |sub_task|
  json.extract! sub_task, :id, :task_id
  json.url sub_task_url(sub_task, format: :json)
end
