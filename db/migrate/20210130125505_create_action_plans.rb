class CreateActionPlans < ActiveRecord::Migration[6.0]
  def change
    create_table :action_plans do |t|
      t.string :plan
      t.references :reviews, null: false, foreign_key: true

      t.timestamps
    end
  end
end
