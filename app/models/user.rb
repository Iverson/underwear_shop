class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :first_name, :last_name, :phone, :terms_of_service
  # attr_accessible :title, :body
  
  validates :first_name, :presence => true
  validates :last_name, :presence => true
  validates :phone, :presence => true
  validates :password, :presence => true, :confirmation => true
  validates :password_confirmation, :presence => true
  validates :terms_of_service, :acceptance => { :accept => true }
  
  has_one :address
  
  accepts_nested_attributes_for :address
  
  after_create() do
    Address.create({:address => "", :city => "", :phone => "", :fio => self.first_name + " " + self.last_name, :user_id => self.id})
  end
end
