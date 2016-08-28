
class LineItemsController < ApplicationController
  before_action :authorize
  def create
    line_item = LineItem.where(:shopping_cart_id => active_cart.id, :product_id => params[:line_item][:product_id]).first_or_initialize
    if line_item.quantity
      line_item.quantity+=params[:line_item][:quantity].to_i
      line_item.save
    else
      line_item.quantity = params[:line_item][:quantity]
      line_item.save
    end
    shopping_cart = ShoppingCart.find(active_cart.id)
    redirect_to shopping_cart_path(shopping_cart)
  end

  def update
    line_item = LineItem.find(params[:id])
    line_item.update(safe_params)
    shopping_cart = ShoppingCart.find(params[:line_item][:shopping_cart_id])
    redirect_to shopping_cart_path(shopping_cart)
    flash[:notice] = "Your cart has been updated"
  end

  def reset

    line_items = LineItem.where(shopping_cart_id: active_cart.id)
    line_items.each do |item|
      item.quantity=0
      item.save
    end
    redirect_to '/'
  end

private
  def safe_params
    params.require(:line_item).permit(:quantity, :shopping_cart_id, :product_id)
  end

end
