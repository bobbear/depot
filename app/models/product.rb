class Product < ActiveRecord::Base

  #默认使用title进行排序
  #default_scope {where(order:'title')}

  validates :title, :description, :image_url, :presence => true

  validates :title, :uniqueness => true, :length => {:minimum => 10}

  validates :price, :numericality => {:greater_than_or_equal_to => 0.01}

  validates :image_url, :format => {
    :with      => %r{\.(gif|jpg|png)\z}i,
    :message   => 'must be a URL for GIF, JPG or PNG images.'
  }
end
