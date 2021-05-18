class AddTaglineToReviews < ActiveRecord::Migration[6.0]
  def up
    add_column :reviews, :tegline, :string, limit: 25, null: false
    change_column :reviews, :text, :text
  end

  def down
    remove_column :reviews, :tegline, :string, null: false
    change_column :reviews, :text, :string
  end
end
