class AddColorToCategories < ActiveRecord::Migration[7.1]
  def change
    add_column :categories, :color, :string
  end
end
