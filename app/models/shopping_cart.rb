class ShoppingCart < ApplicationRecord
  belongs_to :buyer
  has_many :line_items
  has_many :products, through: :line_items

  def total
    line_items = LineItem.where(shopping_cart_id: self.id)
    total = 0
    line_items.each do |line_item|
      total += line_item.quantity * line_item.product.unit_price
    end
    total
  end

  def total_quantity
    line_items = LineItem.where(shopping_cart_id: self.id)
    total_quantity = 0
    line_items.each do |line_item|
      total_quantity += line_item.quantity
    end
    total_quantity
  end
end
