class Product < ApplicationRecord
  has_many :line_items
  has_many :shopping_carts, through: :line_items
  has_many :buyers, through: :line_items
  
end
