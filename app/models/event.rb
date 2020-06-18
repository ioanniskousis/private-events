class Event < ApplicationRecord
  belongs_to :creator, class_name: "User", foreign_key: "user_id"
  has_and_belongs_to_many :attendees, class_name: "User", inverse_of: "attended_events", through: :events_users

  validates :description, presence: true
  validates :location, presence: true

  def self.upcoming_events
    self.all.filter { |e| e.event_date > Time.now }
  end

  def self.previous_events
    self.all.filter { |e| e.event_date < Time.now }
  end

  scope :future_events, ->(date) { where("event_date > ?", date) }
  scope :past_events, ->(date) { where("event_date < ?", date) }
end
