class User < ApplicationRecord
  has_many :events, inverse_of: 'creator', dependent: :destroy
  has_and_belongs_to_many :attended_events, class_name: "Event", inverse_of: 'attendees', through: :events_users
 
  validates :name, presence: true
end 
