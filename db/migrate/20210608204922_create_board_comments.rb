class CreateBoardComments < ActiveRecord::Migration[6.0]
  def change
    create_table :board_comments do |t|
      t.text :text, null: false
      t.references :board, null:false, foreign_key: true
      t.references :user,  null:false, foreign_key: true

      t.timestamps
    end
  end
end
