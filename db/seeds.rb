u = User.new({
  :email                 => 'canglan@gmail.com',
  :password              => 'test',
  :password_confirmation => 'test',
  :first_name            => 'Fred',
  :last_name             => 'Wu',
  :city                  => 'Melbourne',
  :credit                => 20,
  :email_notification    => true,
  :confirmed_at          => Time.now,
  :is_admin              => true,
})
u.save :validate => false