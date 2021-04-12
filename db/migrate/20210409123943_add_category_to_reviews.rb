class AddCategoryToReviews < ActiveRecord::Migration[6.0]
  def change
    add_column :reviews, :category, :integer, null: false
  end
end
