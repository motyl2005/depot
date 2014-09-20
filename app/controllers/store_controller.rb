class StoreController < ApplicationController

  include CurrentCart
  before_action :set_cart
  def index
    @products = Product.order(:price)
    @count = increment_count
    @shown_message = "You've been here #{@count} times" if @count >= 5
  end


  def increment_count
    session[:counter] ||= 0
    session[:counter] += 1
  end

end
