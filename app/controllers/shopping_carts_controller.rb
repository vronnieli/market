require 'pry'
class ShoppingCartsController < ApplicationController
before_action :authorize

  def show
      @shopping_cart = active_cart
      if @shopping_cart.line_items
        @line_items = @shopping_cart.line_items
      else
        @line_items = []
      end
  end

  # def index
  #   @shopping_carts = ShoppingCart.all
  # end

  def update
    @shopping_cart = active_cart
    no_stock = @shopping_cart.line_items.any? do |line_item|
      line_item.product.quantity < line_item.quantity
    end
    if no_stock
      redirect_to shopping_cart_path(@shopping_cart)
      flash[:notice] = "There are not enough items in stock to satisfy your order."
    else
      @shopping_cart.line_items.each do |line_item|
        line_item.product.quantity-= line_item.quantity
        line_item.product.save
      end
      @shopping_cart.status = false
      @shopping_cart.save
      ShoppingCart.create(buyer_id: session[:buyer_id])
      redirect_to '/'
    end
  end

  def destroy
    shopping_cart = ShoppingCart.find(params[:id])
    shopping_cart.destroy
    ShoppingCart.create(buyer_id: session[:buyer_id])
    redirect_to '/'
  end

  def orders
    @orders = ShoppingCart.where(buyer_id: session[:buyer_id], status: false)
    if @orders
      @line_items = {}
      @orders.each do |order|
        @line_items["#{order.id}"] = order.line_items
      end
    else
      @orders = []
      @line_items = {}
    end
  end

end
