require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  fixtures :products
  test "product attributes must not be empty" do
  product = Product.new
    assert product.invalid?
    assert product.errors[:title].any?
    assert product.errors[:description].any?
    assert product.errors[:price].any?
    assert product.errors[:image_url].any?
  end


  test "product price must be positive" do
    product = Product.new(title:"My Book Title",
                          description:"jhgjhag",
                          image_url:"jhg.png")
    product.price = -1

    assert product.invalid?
    assert_equal ["must be greater than or equal to 0.01"],
                 product.errors[:price]

    product.price = 0
    assert product.invalid?
    assert_equal ["must be greater than or equal to 0.01"],
                 product.errors[:price]
    product.price = 1
    assert product.valid?
  end

  def new_product(image)
    Product.new(title: 'MyBookIsTheBest',
    description: 'kjhk',
    price: 1,
    image_url: image)
  end

  test "image url" do
    ok = %w{ fred.jpg fred.png FRED.JPG FRED.Jpg http://a.b.c/x/y/z/fred.gif fred.gif }
    bad = %w{ fred.doc fred.gif/more fred.gif.more }

    ok.each do |name|
      assert new_product(name).valid?, " #{name} should be valid"
    end

    bad.each do |name|
      assert new_product(name).invalid?, "#{name} shouldn't be valid"
    end
  end

  test "product is not valid without a unique title" do
    product = Product.new(title: products(:ruby).title,
                          description: "fjhgsj",
                          price: 1,
                          image_url: "bob.png"    )

    assert product.invalid?
    assert_equal [I18n.translate('errors.messages.taken')], product.errors[:title]
  end

  test "product is not valid without a unique image URL" do
    product = Product.new(title: "Pascalinessa",
    description: "adjhg",
    price: 2,
    image_url: "ruby.jpg" )

    assert product.invalid?



  end


end
