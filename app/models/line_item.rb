class LineItem < ApplicationRecord
  belongs_to :shopping_cart
  belongs_to :product
  has_one :buyer, through: :shopping_cart
  validates :quantity, :numericality => { :greater_than_or_equal_to => 0 }

  def total_price
    self.quantity * self.product.unit_price
  end



end
