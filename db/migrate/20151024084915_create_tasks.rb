class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.references :project, index: true
      t.references :user, index: true
      t.string :url
      t.string :html_url
      t.string :labels_url
      t.integer :github_id, index: true, unique: true
      t.string :number, index: true, unique: true
      t.string :title
      t.string :description
      t.jsonb :creator
      t.string :open_issues
      t.string :closed_issues
      t.string :state
      t.datetime :due_on
      t.datetime :closed_at
      t.datetime :github_created_at
      t.datetime :github_updated_at

      t.timestamps null: false
    end
    add_foreign_key :tasks, :projects
    add_foreign_key :tasks, :users
  end
end
