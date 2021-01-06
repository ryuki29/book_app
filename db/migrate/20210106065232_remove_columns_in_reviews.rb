class RemoveColumnsInReviews < ActiveRecord::Migration[6.0]
  def change
    remove_column :reviews, :user_id, :integer
    remove_column :reviews, :book_id, :integer
  end
end
