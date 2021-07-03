class RemoveColumnsInUsers < ActiveRecord::Migration[6.0]
  def up
    add_column :users, :profile, :string
    remove_column :users, :provider, :string
    remove_column :users, :uid, :string
  end

  def down
    remove_column :users, :profile, :string
    add_column :users, :provider, :string
    add_column :users, :uid, :string
  end
end
