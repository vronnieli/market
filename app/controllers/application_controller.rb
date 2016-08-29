class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :logged_in?, :current_buyer, :active_cart

  def logged_in?
    session[:buyer_id] != nil
  end

  def current_buyer
    @current_buyer ||= Buyer.find(session[:buyer_id]) if logged_in?
  end

  def active_cart
    @active_cart ||= ShoppingCart.where(buyer_id: current_buyer.id, status: true).first
  end

  def authorize
    unless current_buyer #&& current_buyer.id == session[:buyer_id]
      redirect_to '/', notice: "Please log in first."
    end
  end
end
