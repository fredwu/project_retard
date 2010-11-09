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

u = User.new({
  :email                 => 'canglan@gmail.com',
  :password              => 'test',
  :password_confirmation => 'test',
  :first_name            => 'Fred',
  :last_name             => 'Wu',
  :city                  => 'Melbourne',
  :confirmed_at          => Time.now,
  :is_admin              => true,
  :retailer_id           => 1,
})
u.save :validate => false

u = User.new({
  :email                 => 'riley@socialistamedia.com',
  :password              => 'bondi1000',
  :password_confirmation => 'bondi1000',
  :first_name            => 'Riley',
  :last_name             => 'Batchelor',
  :city                  => 'Sydney',
  :confirmed_at          => Time.now,
  :is_admin              => true,
  :retailer_id           => 1,
})
u.save :validate => false

Size.create({:name => "S"})
Size.create({:name => "M"})
Size.create({:name => "L"})

Colour.create({:hex => "00ffff", :name => "Red"})
Colour.create({:hex => "ffff00", :name => "Blue"})

Product.create({
  :code               => "TEST_PROD",
  :name               => "Test Product",
  :details            => "This is a test product.",
  :highlights         => "Awesome product!",
  :rrp                => 99.95,
  :price              => 49.95,
  :limit_per_customer => 3,
  :minimum_purchases  => 20,
  :is_voucher         => false,
  :retailer_id        => 1,
})

  ProductItem.create({
    :stock      => 10,
    :product_id => 1,
    :colour_id  => 1,
    :size_id    => 1,
  })

  ProductItem.create({
    :stock      => 10,
    :product_id => 1,
    :colour_id  => 1,
    :size_id    => 2,
  })

  ProductItem.create({
    :stock      => 0,
    :product_id => 1,
    :colour_id  => 2,
    :size_id    => 3,
  })

Product.create({
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
  :start_at           => Time.now.tomorrow,
})

  ProductVoucher.create({
    :code       => "VOUCHER_TEST_PROD_2",
    :limit      => 10,
    :product_id => 2,
  })

Product.create({
  :code               => "TEST_PROD_3",
  :name               => "Test Product 3",
  :details            => "This is yet another test product.",
  :terms              => "Brilliant.",
  :rrp                => 69.95,
  :price              => 59.95,
  :limit_per_customer => 1,
  :is_voucher         => false,
  :retailer_id        => 1,
  :start_at           => Time.now,
  :end_at             => 3.days.from_now,
})

  ProductItem.create({
    :stock      => 10,
    :product_id => 3,
    :colour_id  => 2,
    :size_id    => 2,
  })

Product.create({
  :code               => "TEST_PROD_4",
  :name               => "Test Product 4",
  :details            => "This is a test product as well.",
  :rrp                => 9.95,
  :price              => 4.95,
  :limit_per_customer => 1,
  :retailer_id        => 1,
})
