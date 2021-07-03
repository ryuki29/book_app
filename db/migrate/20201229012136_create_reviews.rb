class CreateReviews < ActiveRecord::Migration[6.0]
  def change
    create_table :reviews do |t|
      t.date       :date
      t.string     :text
      t.integer    :rating
      t.integer :user_id
      t.integer :book_id
      t.timestamps
    end
  end
end
