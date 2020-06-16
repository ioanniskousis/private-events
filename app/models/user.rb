class User < ApplicationRecord
  has_many :events, inverse_of: 'creator', dependent: :destroy
end 
