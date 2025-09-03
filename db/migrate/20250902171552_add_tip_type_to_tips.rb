class AddTipTypeToTips < ActiveRecord::Migration[7.1]
  def change
    add_column :tips, :tip_type, :string
  end
end
