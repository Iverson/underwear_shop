# coding: utf-8
class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :first_name, :last_name, :phone, :terms_of_service, :addresses_attributes
  # attr_accessible :title, :body
  
  validates :first_name, :presence => true
  validates :last_name, :presence => true
  validates :phone, :presence => true
  validates :password, :presence => true, :confirmation => true
  validates :password_confirmation, :presence => true
  validates :terms_of_service, :acceptance => { :accept => true }
  
  has_one :address, :as => :addressable
  has_many :orders
  has_many :favorites, :dependent => :destroy
  
  accepts_nested_attributes_for :address
  
  after_create() do
    self.create_address({:address => "", :city => "Москва", :phone => self.phone, :email => self.email, :fio => self.first_name + " " + self.last_name, :user_id => self.id})
    UserMailer.welcome_email(self).deliver
  end
  
  def fio
      self.first_name + " " + self.last_name
  end
end
