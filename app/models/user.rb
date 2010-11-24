class User < ActiveRecord::Base
  include Datamappify::Resource
  include ActionView::Helpers::NumberHelper

  CITIES      = %w{Adelaide Brisbane Canberra Darwin Hobart Melbourne Perth Sydney}
  EMAIL_REGEX = /^[A-Z0-9._%-]+@(?:[A-Z0-9-]+\.)+[A-Z]{2,6}$/i

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable

  # Setup accessible (or protected) attributes for your model
  # attr_accessible :email, :first_name, :last_name, :payment_email, :password, :password_confirmation

  property  :email,                   :string,  :default => "", :null => false
  property  :first_name,              :string,  :limit => 50
  property  :last_name,               :string,  :limit => 50
  property  :city,                    :string,  :limit => 20
  property  :address,                 :text
  property  :postcode,                :string,  :limit => 10
  property  :email_notification,      :boolean, :default => false
  property  :credit,                  :decimal, :precision => 6, :scale => 2, :default => 0
  property  :referral_credit_claimed, :boolean, :default => false
  property  :encrypted_password,      :string,  :limit => 128, :default => "", :null => false
  property  :password_salt,           :string,  :default => "", :null => false
  property  :reset_password_token,    :string
  property  :remember_token,          :string
  property  :remember_created_at,     :datetime
  property  :sign_in_count,           :integer, :default => 0
  property  :current_sign_in_at,      :datetime
  property  :last_sign_in_at,         :datetime
  property  :current_sign_in_ip,      :string
  property  :last_sign_in_ip,         :string
  property  :confirmation_token,      :string
  property  :confirmed_at,            :datetime
  property  :confirmation_sent_at,    :datetime
  property  :is_admin,                :boolean, :default => 0
  property  :timestamps

  add_index :email,                :unique => true
  add_index :confirmation_token,   :unique => true
  add_index :reset_password_token, :unique => true

  has_one    :cart, :dependent => :destroy
  belongs_to :retailer
  belongs_to :referee, :class_name => :user

  validates_presence_of   :first_name
  validates_presence_of   :last_name
  validates_presence_of   :email
  validates_presence_of   :city
  validates_uniqueness_of :email
  validates_format_of     :email, :with => EMAIL_REGEX

  def is_admin?
    is_admin
  end

  def is_retailer?
    !!retailer
  end

  def fancy_credit
    number_to_currency(credit)
  end
end
