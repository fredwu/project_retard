u = User.new({
  :email                 => 'canglan@gmail.com',
  :password              => 'test',
  :password_confirmation => 'test',
  :first_name            => 'Fred',
  :last_name             => 'Wu',
  :deal_city             => 'Melbourne',
  :credit                => 20,
  :email_notification    => true,
  :confirmed_at          => Time.now,
  :is_admin              => true,
})
u.save :validate => false

  Cart.create({
    :user       => u,
    :first_name => 'Fred',
    :last_name  => 'Wu',
    :address    => 'Earth',
    :city       => 'Melbourne',
    :state      => 'Victoria',
    :postcode   => '3000',
    :country    => 'Australia',
  })

u = User.new({
  :email                 => 'riley@socialistamedia.com',
  :password              => 'bondi1000',
  :password_confirmation => 'bondi1000',
  :first_name            => 'Riley',
  :last_name             => 'Batchelor',
  :deal_city             => 'Sydney',
  :email_notification    => true,
  :confirmed_at          => Time.now,
  :is_admin              => true,
  :retailer_id           => 1,
})
u.save :validate => false

u = User.new({
  :email                 => 'katrina@socialistamedia.com',
  :password              => 'password123',
  :password_confirmation => 'password123',
  :first_name            => 'Katrina',
  :last_name             => 'Goh',
  :deal_city             => 'Sydney',
  :email_notification    => true,
  :confirmed_at          => Time.now,
  :is_admin              => true,
  :retailer_id           => 1,
})
u.save :validate => false