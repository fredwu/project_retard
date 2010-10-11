class User < ActiveRecord::Base
  include Datamappify::Resource
  
  EMAIL_REGEX = /^[A-Z0-9._%-]+@(?:[A-Z0-9-]+\.)+[A-Z]{2,6}$/i
  
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable
  
  # Setup accessible (or protected) attributes for your model
  # attr_accessible :email, :first_name, :last_name, :payment_email, :password, :password_confirmation
  
  property  :email, :string, :default => "", :null => false
  property  :first_name, :string, :limit => 50
  property  :last_name, :string, :limit => 50
  property  :encrypted_password, :string, :limit => 128, :default => "", :null => false
  property  :password_salt, :string, :default => "", :null => false
  property  :reset_password_token, :string
  property  :remember_token, :string
  property  :remember_created_at, :datetime
  property  :sign_in_count, :integer, :default => 0
  property  :current_sign_in_at, :datetime
  property  :last_sign_in_at, :datetime
  property  :current_sign_in_ip, :string
  property  :last_sign_in_ip, :string
  property  :confirmation_token, :string
  property  :confirmed_at, :datetime
  property  :confirmation_sent_at, :datetime
  property  :timestamps
  
  add_index :email, :unique => true
  add_index :confirmation_token, :unique => true
  add_index :reset_password_token, :unique => true
end
