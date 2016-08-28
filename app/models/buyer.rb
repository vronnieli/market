class Buyer < ApplicationRecord
  has_many :shopping_carts
  has_many :line_items, through: :shopping_carts
  has_many :products, through: :line_items
  validates :name, presence: true
  validates :password, presence: true
  has_secure_password

end
