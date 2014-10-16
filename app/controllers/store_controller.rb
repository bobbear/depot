class StoreController < ApplicationController
  def index
    @products = Product.all
    calculate_access_index_times_for_one_user
  end
  private
  def calculate_access_index_times_for_one_user 
    if session[:counter].nil?
      session[:counter] = 1
    else
      session[:counter] += 1
    end
  end
end
