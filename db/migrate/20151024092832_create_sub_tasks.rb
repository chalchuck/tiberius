class CreateSubTasks < ActiveRecord::Migration
  def change
    create_table :sub_tasks do |t|
      t.references :task, index: true
      t.string :url
      t.string :labels_url
      t.string :comments_url
      t.string :events_url
      t.string :html_url
      t.integer :github_id
      t.string :number
      t.string :title
      t.string :labels
      t.string :state
      t.string :locked
      t.string :comments
      t.datetime :github_created_at
      t.datetime :github_updated_at
      t.datetime :closed_at
      t.timestamps null: false
    end
    add_foreign_key :sub_tasks, :tasks
  end
end
