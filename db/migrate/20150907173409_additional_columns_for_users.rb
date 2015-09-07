class AdditionalColumnsForUsers < ActiveRecord::Migration
  def change
    # Added Columns for Users Table
    add_column :users, :role_id, :integer
    add_column :users, :first_name, :string
    add_column :users, :middle_name, :string
    add_column :users, :last_name, :string
    add_column :users, :description, :text
    add_attachment :users, :photo
  end
end
