class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.integer :github_id
      t.string :name
      t.string :slug
      t.string :description
      t.references :user, index: true

      t.timestamps null: false
    end
    add_index :projects, :name
    add_index :projects, :slug
    add_foreign_key :projects, :users
  end
end
