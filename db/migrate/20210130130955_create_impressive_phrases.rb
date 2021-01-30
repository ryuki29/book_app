class CreateImpressivePhrases < ActiveRecord::Migration[6.0]
  def change
    create_table :impressive_phrases do |t|
      t.text :phrase
      t.references :reviews, null: false, foreign_key: true

      t.timestamps
    end
  end
end
