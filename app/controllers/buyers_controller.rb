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
    if params[:id].to_i != current_buyer.id
      redirect_to '/'
    else
      @buyer = Buyer.find(params[:id])
      @shopping_carts = @buyer.shopping_carts
    end
  end

  def edit
    @buyer = Buyer.find(params[:id])
  end

  def update
    buyer = Buyer.find(current_buyer.id)
    buyer.update(buyer_params)
    redirect_to buyer_path(buyer)
  end

  def destroy
  current_buyer.delete
  session[:buyer_id] = nil
  redirect_to '/'
  end

private

  def buyer_params
    params.require(:buyer).permit(:name, :password)
  end

end
