class AddColumnsToReviews < ActiveRecord::Migration[6.0]
  def change
    add_reference :reviews, :user, foreign_key: true
    add_reference :reviews, :book, foreign_key: true
  end
end
