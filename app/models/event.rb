class Event < ActiveRecord::Base
  belongs_to :host, :class_name => "User"
  has_many :event_guests
  has_many :guests, through: :event_guests, :class_name => "User"
end
