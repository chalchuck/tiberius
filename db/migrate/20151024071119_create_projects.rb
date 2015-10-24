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
    add_index :projects, :name, unique: true
    add_index :projects, :slug, unique: true
    add_foreign_key :projects, :users
  end
end
