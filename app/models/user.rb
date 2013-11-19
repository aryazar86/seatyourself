class User < ActiveRecord::Base

  has_many :reservations
  has_many :restaurants, :through => :reservations

  authenticates_with_sorcery!

  validates_confirmation_of :password
  validates_presence_of :password, :on => :create
  validates_presence_of :email
  validates_uniqueness_of :email

  def gravitar_url
    gravitar = Digest::MD5.hexdigest(email)
    "http://www.gravatar.com/avatar/#{gravitar}.jpg"
  end
end
