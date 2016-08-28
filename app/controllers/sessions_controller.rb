class SessionsController < ApplicationController
before_action :authorize, only: [:destroy]
  def new
    @buyer = Buyer.new
  end

  def create
    buyer = Buyer.find_by(name: buyer_params[:name])
    if buyer && buyer.authenticate(buyer_params[:password])
      session[:buyer_id] = buyer.id
      redirect_to '/'
    else
      render 'new'
    end
  end

  def destroy
    session[:buyer_id] = nil
    redirect_to '/'
  end

  private

  def buyer_params
    params.require(:buyer).permit(:name, :password)
  end

end
