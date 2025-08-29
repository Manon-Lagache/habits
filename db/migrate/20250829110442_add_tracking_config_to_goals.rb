class AddTrackingConfigToGoals < ActiveRecord::Migration[7.1]
  def change
    add_column :goals, :tracking_config, :jsonb, default: {}, null: false
  end
end
