class Reservation < ActiveRecord::Base
  belongs_to :user
  belongs_to :restaurant

  validate :enough_space

  validate :within_business_hours

  validate :is_not_in_past

  def guest_count
    total_guests = 0

    restaurant.reservations.each do |r|
      if r.time_slot == time_slot
        total_guests += r.guests
      end
    end
      total_guests
  end

  def enough_space

    if (guest_count + guests > restaurant.capacity)
      errors.add(:reservation, ": Restaurant is full at this time.")
    end
  end

  def within_business_hours
    if !(10..20).include? time_slot.strftime("%H:%M%p").to_i 
      errors.add(:reservation, ": Restaurant is not open at this time, dumbass!")
    end
  end

  #Check if reservation is for now, or in the future

  def is_not_in_past
    if time_slot < (Time.now.to_time - 5.hours).to_datetime
      errors.add(:reservation, ": Cannot be made in the past, stupido!")
    end
  end

  # def total_guests

  #   total_guests = 0

  #   Restaurant.first.reservations.each do |r|
  #     if r.time_slot == time_slot
  #       total_guests += r.guests
  #     end
  #   end
    
  #   return total_guests

  # end

  # def guest_count

  #   if (total_guests + guests) > 100
  #     errors.add(:guests, "Restaurant is full")
  #   end

  # end

end
