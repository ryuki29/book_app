class AddProgressToActionPlans < ActiveRecord::Migration[6.0]
  def change
    add_column :action_plans, :progress, :integer, default: 0
    add_column :action_plans, :deadline, :date, null: false

    change_column_null :action_plans, :plan, false
    change_column_default :action_plans, :plan, from: nil, to: ""
  end
end
