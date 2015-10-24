class AddLoginAndImageToUsers < ActiveRecord::Migration
  def change
    add_column :users, :login, :string
    add_column :users, :image, :string
    add_column :users, :credentials, :jsonb
    add_column :users, :extra, :jsonb
  end
end
