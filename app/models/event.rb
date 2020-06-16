class Event < ApplicationRecord
  belongs_to :user, class_name: "User"


  
  def creator
    user
  end
  
end
