class User < ApplicationRecord
  has_many :events, inverse_of: 'creator', dependent: :destroy
  has_and_belongs_to_many :attended_events, class_name: "Event", inverse_of: 'attendees', through: :events_users
 
  validates :name, presence: true

  def upcoming_events
    attended_events.filter{ |e| e.event_date > Time.now }
  end

  def previous_events
    attended_events.filter { |e| e.event_date < Time.now }
  end

  # scope :future_events, ->(date) { where("event_date > ?", date) }
  # scope :past_events, ->(date) { where("event_date < ?", date) }
end 

