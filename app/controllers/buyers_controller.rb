class BuyersController < ApplicationController
  before_action :authorize, except: [:new, :create]

  def new
    @buyer = Buyer.new
  end

  def create
    buyer = Buyer.create(buyer_params)
    session[:buyer_id] = buyer.id
    new_shopping_cart = ShoppingCart.create(buyer_id: session[:buyer_id])
    redirect_to '/'
  end

  def show
    @buyer = Buyer.find(params[:id])
    @shopping_carts = @buyer.shopping_carts
  end

  def edit
  end

  def update
  end

private

  def buyer_params
    params.require(:buyer).permit(:name, :password)
  end

end
