Retailer.create({
  :code => "TEST_RET",
  :name => "Test Retailer",
  :info => "This is a test retailer.",
})

u = User.new({
  :email                 => 'canglan@gmail.com',
  :password              => 'test',
  :password_confirmation => 'test',
  :first_name            => 'Fred',
  :last_name             => 'Wu',
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
  :shipping_info      => "Standard shipping rates apply.",
  :rrp                => 99.95,
  :price              => 49.95,
  :limit_per_customer => 3,
  :is_voucher         => 0,
  :retailer_id        => 1,
})

ProductItem.create({
  :stock      => 10,
  :product_id => 1,
  :colour_id  => 1,
  :size_id    => 1,
})
