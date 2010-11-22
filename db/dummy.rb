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

r = Retailer.create({
  :code            => "2THREADS",
  :name            => "2threads",
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
r.logo.store!(helpers.image_file("logo-2threads.png"))
r.save

Size.create({:name => "S"})
Size.create({:name => "M"})
Size.create({:name => "L"})
Size.create({:name => "XL"})
Size.create({:name => "XXL"})

Colour.create({:hex => "ff0000", :name => "Red"})
Colour.create({:hex => "0000ff", :name => "Blue"})
Colour.create({:hex => "00ff00", :name => "Green"})

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
    :product => p,
    :code    => "VOUCHER_TEST_PROD_2",
    :limit   => 10,
  })

  img = ProductImage.create(:product => p)
  img.file.store!(helpers.image_file("4_b.jpg"))
  p.product_images << img

p = Product.create({
  :code               => "TEST_PROD_3",
  :name               => "Test Product 3",
  :details            => "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas nec imperdiet ipsum. Suspendisse sem sem, mollis sit amet semper et, varius vel ipsum. Nulla interdum interdum mi in tincidunt. Curabitur pharetra eleifend nulla et viverra. Quisque in accumsan magna. Curabitur non felis mi. Integer ultricies augue sodales eros tempus viverra. Pellentesque sit amet massa non dolor suscipit venenatis. Mauris fringilla fermentum sapien at euismod. Sed a augue ac risus adipiscing tincidunt. Sed sit amet elementum tortor. Aliquam dictum sodales eros eget malesuada. Morbi hendrerit elementum sagittis. Maecenas placerat ullamcorper ipsum sit amet viverra. Donec pulvinar, nisi quis hendrerit posuere, neque elit dignissim nunc, sed pharetra dolor nisl at lectus.",
  :highlights         => "Aliquam nec enim non nisi vestibulum elementum. Cras dictum vehicula lacus, ac laoreet est viverra eu. Etiam tempor consequat dolor, sed cursus nisi malesuada lacinia. Phasellus sed erat sed nibh porttitor sagittis. Quisque mollis, nisl consectetur ullamcorper lacinia, mauris turpis blandit felis, quis scelerisque nunc leo sit amet risus. Etiam eget purus mi. Fusce egestas hendrerit leo, ut condimentum sapien sollicitudin vestibulum.",
  :terms              => "Ut augue felis, tristique non rhoncus eget, dapibus ut erat. Nunc nisl turpis, molestie eget tempus sed, molestie ac risus. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Suspendisse potenti. Sed quis felis sed magna semper blandit. Praesent convallis, ipsum ac feugiat pharetra, massa velit viverra ipsum, sed gravida diam eros non lectus. Nulla ut urna vitae lectus porta ultricies sit amet at massa.",
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
    :product   => p,
    :stock     => 10,
    :colour_id => 2,
    :size_id   => 2,
  })

  ProductItem.create({
    :product   => p,
    :stock     => 10,
    :colour_id => 1,
    :size_id   => 3,
  })

  ProductItem.create({
    :product   => p,
    :stock     => 10,
    :colour_id => 1,
    :size_id   => 2,
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
    :product   => p,
    :stock     => 10,
    :colour_id => 3,
    :size_id   => 3,
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