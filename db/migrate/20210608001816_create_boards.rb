class CreateBoards < ActiveRecord::Migration[6.0]
  def change
    create_table :boards do |t|
      t.string  :title,       null: false
      t.integer :board_type,  null: false
      t.text    :description, null: false
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
