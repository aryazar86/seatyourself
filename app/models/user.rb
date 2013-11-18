class User < ActiveRecord::Base

  has_many :reservations
  has_many :restaurants, :through => :reservations

  authenticates_with_sorcery!

  validates_confirmation_of :password
  validates_presence_of :password, :on => :create
  validates_presence_of :email
  validates_uniqueness_of :email
end
