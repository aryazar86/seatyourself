class Restaurant < ActiveRecord::Base
  belongs_to :category

  has_many :reservations
  has_many :users, :through => :reservations

  mount_uploader :image, ImageUploader
  

  def has_space(user_choice_time)
    total_guests = 0
    self.reservations.each do |res|
      if res.time_slot == user_choice_time
        total_guests += res.guests
      end
    end

    if total_guests < self.capacity
      return true
    end
    
  end

end
