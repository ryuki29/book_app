class CreateBooks < ActiveRecord::Migration[6.0]
  def change
    create_table :books do |t|
      t.string :title
      t.string :authors
      t.string :image_url, null: false
      t.string :uid,       null: false
      t.timestamps
    end
  end
end
