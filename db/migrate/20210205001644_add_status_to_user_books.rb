class AddStatusToUserBooks < ActiveRecord::Migration[6.0]
  def change
    add_column :user_books, :status, :integer, null: false, limit: 1
  end
end
