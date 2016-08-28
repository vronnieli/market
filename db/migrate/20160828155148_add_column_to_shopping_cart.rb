class AddColumnToShoppingCart < ActiveRecord::Migration[5.0]
  def change
    add_column :shopping_carts, :status, :boolean, default: true
  end
end
