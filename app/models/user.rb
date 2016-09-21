class User < ActiveRecord::Base
  #for host
  has_many :events, :foreign_key => 'host_id'
  has_many :guests, through: :events 
  #for guest
  has_many :event_guests, :foreign_key => "guest_id"
end
