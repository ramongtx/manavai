class AddUsername < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :username, :string, null: false, unique: true, default: ''
    add_column :users, :role, :string, null: false, default: 'free'
  end
end
