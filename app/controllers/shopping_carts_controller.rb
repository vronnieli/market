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
    @shopping_cart.status = false
    @shopping_cart.save
    ShoppingCart.create(buyer_id: session[:buyer_id])
    redirect_to '/'
  end

  def destroy
    shopping_cart = ShoppingCart.find(params[:id])
    shopping_cart.destroy
    redirect_to shopping_carts_path
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
