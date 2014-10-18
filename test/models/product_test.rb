require 'test_helper'

class ProductTest < ActiveSupport::TestCase

  test "product attributes must not empty" do
    product = Product.new
    assert product.invalid?
    assert product.errors[:title].any?
    assert product.errors[:description].any?
    assert product.errors[:price].any?
    assert product.errors[:image_url].any?
  end

  test "product price must be positive" do 
    product = Product.new(:title => "my book title",
                         :description => "yyy",
                         :image_url => 'zzz.jpg')
    product.price = -1
    assert product.invalid?
    assert_equal "must be greater than or equal to 0.01",
      product.errors[:price].join('; ')

    product.price = 0
    assert product.invalid?
    assert_equal "must be greater than or equal to 0.01",
      product.errors[:price].join("; ")

    product.price = 1
    assert product.valid?
  end

  test "product image_url must be valid format" do
    ok = %w{a.jpg a.gif a.png b.JPG b.GIF b.PNG }
    bad = %w{a.doc b.xls c.jpga }
    ok.each do |image_url|
      product = new_product image_url
      assert product.valid?
    end

    bad.each do |image_url|
      product = new_product image_url
      assert product.invalid?
    end
  end

  test "product title length must greater than 10" do
    product = Product.new(:title =>'a',:description=>'abc',:price=>20,:image_url=>'a.jpg')
    assert product.invalid?
  end

  test "product title must be unique" do 
    product = Product.new(:title => products(:ruby).title,:description=>'abc',:price=>20,:image_url=>'a.jpg')
    assert product.invalid?
  end

  def new_product(image_url)
    Product.new(
                :title  => 'aTitle about aBook',
           :description => 'aDescription',
         :price         => 10,
         :image_url     => image_url)
  end
end
