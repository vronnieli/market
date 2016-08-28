class AddColumnToProducts < ActiveRecord::Migration[5.0]
  def change
    add_column :products, :unit_price, :float
  end
end
