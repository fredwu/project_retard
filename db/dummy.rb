module Shop2T
  module Dummy
    module Helpers
      class << self
        def image_path(filename)
          File.join(Rails.root, "db", "fixtures", "images", filename)
        end

        def image_file(filename)
          File.open(image_path(filename))
        end
      end
    end
  end
end

helpers = Shop2T::Dummy::Helpers

Retailer.create({
  :code            => "TEST_RET",
  :name            => "Test Retailer",
  :website         => "http://www.2threads.com/",
  :contact_details => %q{
2threads - Sydney Head Office
6 Kings Lane
Darlinghurst
NSW Australia 2010
Ph: 02 9357 7356
Fax: 02 8356 9180
Email: feedback@2threads.com
},
})

Size.create({:name => "S"})
Size.create({:name => "M"})
Size.create({:name => "L"})
Size.create({:name => "XL"})
Size.create({:name => "XXL"})

Colour.create({:hex => "00ffff", :name => "Red"})
Colour.create({:hex => "ffff00", :name => "Blue"})
Colour.create({:hex => "ff00ff", :name => "Green"})

p = Product.create({
  :code               => "TEST_PROD",
  :name               => "Test Product",
  :details            => "This is a test product.",
  :highlights         => "Awesome product!",
  :rrp                => 99.95,
  :price              => 49.95,
  :shipping_au        => 15,
  :shipping_int       => 25,
  :limit_per_customer => 3,
  :minimum_purchases  => 20,
  :is_voucher         => false,
  :retailer_id        => 1,
  :is_activated       => true,
  :start_at           => Time.now,
  :end_at             => 20.days.from_now,
})

  ProductItem.create({
    :product   => p,
    :stock     => 10,
    :colour_id => 1,
    :size_id   => 1,
  })

  ProductItem.create({
    :product   => p,
    :stock     => 10,
    :colour_id => 1,
    :size_id   => 2,
  })

  ProductItem.create({
    :product   => p,
    :stock     => 10,
    :colour_id => 2,
    :size_id   => 3,
  })

  (1..3).each do |i|
    img = ProductImage.create(:product => p)
    img.file.store!(helpers.image_file("#{i}_b.jpg"))
    p.product_images << img
  end

p = Product.create({
  :code               => "TEST_PROD_2",
  :name               => "Test Product 2",
  :details            => "This is another test product.",
  :highlights         => "Good product.",
  :terms              => "Buy now, don't miss out!",
  :rrp                => 0,
  :price              => 49.95,
  :limit_per_customer => 0,
  :is_voucher         => true,
  :retailer_id        => 1,
  :is_activated       => true,
  :start_at           => 10.days.from_now,
})

  ProductVoucher.create({
    :code       => "VOUCHER_TEST_PROD_2",
    :limit      => 10,
    :product_id => 2,
  })

  img = ProductImage.create(:product => p)
  img.file.store!(helpers.image_file("4_b.jpg"))
  p.product_images << img

p = Product.create({
  :code               => "TEST_PROD_3",
  :name               => "Test Product 3",
  :details            => "This is yet another test product.",
  :terms              => "Brilliant.",
  :rrp                => 69.95,
  :price              => 59.95,
  :shipping_au        => 15,
  :shipping_int       => 25,
  :limit_per_customer => 1,
  :is_voucher         => false,
  :retailer_id        => 1,
  :is_activated       => true,
  :start_at           => Time.now,
  :end_at             => 10.days.from_now,
})

  ProductItem.create({
    :stock      => 10,
    :product_id => 3,
    :colour_id  => 2,
    :size_id    => 2,
  })

  (5..6).each do |i|
    img = ProductImage.create(:product => p)
    img.file.store!(helpers.image_file("#{i}_b.jpg"))
    p.product_images << img
  end

p = Product.create({
  :code               => "TEST_PROD_4",
  :name               => "Test Product 4",
  :details            => "This is a test product as well.",
  :rrp                => 9.95,
  :price              => 4.95,
  :shipping_au        => 15,
  :shipping_int       => 25,
  :limit_per_customer => 1,
  :retailer_id        => 1,
  :start_at           => Time.now,
})

  ProductItem.create({
    :stock      => 10,
    :product_id => 4,
    :colour_id  => 3,
    :size_id    => 3,
  })

  (7..9).each do |i|
    img = ProductImage.create(:product => p)
    img.file.store!(helpers.image_file("#{i}_b.jpg"))
    p.product_images << img
  end

p = Product.create({
  :code               => "TEST_PROD_5",
  :name               => "Test Product 5",
  :details            => "Yet another test product as well.",
  :rrp                => 9.95,
  :price              => 4.95,
  :shipping_au        => 15,
  :shipping_int       => 25,
  :limit_per_customer => 1,
  :retailer_id        => 1,
})