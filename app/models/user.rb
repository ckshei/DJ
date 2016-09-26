class User < ActiveRecord::Base
  serialize :spotify_hash, Hash
  serialize :top_tracks, Array
  serialize :top_artists, Array

  has_secure_password validations: false

  has_many :songs
  accepts_nested_attributes_for :songs, reject_if: proc { |attributes| attributes['name'].blank? }
  #for host
  has_many :events, :foreign_key => 'host_id'
  has_many :guests, through: :events 
  #for guest
  has_many :event_guests, :foreign_key => "guest_id"
  has_many :reservations, through: :event_guests, :source =>"event"

  validates :password, presence:true, length: {minimum: 6}, unless: :has_uid
  validates :display_name, presence:true
  validates :email, presence:true

  def has_uid
    self.uid?
  end
end
