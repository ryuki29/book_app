class CreateUserBooks < ActiveRecord::Migration[6.0]
  def change
    create_table :user_books do |t|
      t.references :user,   foreign_key: true
      t.references :book,   foreign_key: true
    end
  end
end
