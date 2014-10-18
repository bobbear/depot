class LineItem < ActiveRecord::Base
  belongs_to :product
  belongs_to :cart

  def price
    return product.price * quantity
  end
end
