class CreateLineItems < ActiveRecord::Migration[5.0]
  def change
    create_table :line_items do |t|
      t.integer :shopping_cart_id
      t.integer :product_id
      t.integer :quantity

      t.timestamps
    end
  end
end
