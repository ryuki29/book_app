class AddProgressToActionPlans < ActiveRecord::Migration[6.0]
  def change
    add_column :action_plans, :progress, :integer, default: 0
  end
end
