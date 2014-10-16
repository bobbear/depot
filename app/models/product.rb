class Product < ActiveRecord::Base

  #默认使用title进行排序
  #default_scope {where(order:'title')}

  has_many :line_items

  validates :title, :description, :image_url, :presence => true

  validates :title, :uniqueness => true, :length => {:minimum => 10}

  validates :price, :numericality => {:greater_than_or_equal_to => 0.01}

  validates :image_url, :format => {
    :with      => %r{\.(gif|jpg|png)\z}i,
    :message   => 'must be a URL for GIF, JPG or PNG images.'
  }

  before_destroy :ensure_not_referenced_by_any_line_item

  private

  def ensure_not_referenced_by_any_line_item
    if line_items.empty?
      return true
    else
      errors.add(:base, 'Line Items present还有定单存在')
      return false
    end
  end
end
