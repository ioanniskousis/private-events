require 'rails_helper'

RSpec.describe Event, type: :model do
  before :each do
    User.create(name: 'Paul')
    User.create(name: 'Sum')
  end

  it 'user1 creates an event' do
    user1 = User.find(1)

    event = user1.events.create(description: 'Event one', location: 'Home', event_date: '2020-12-31')

    expect(event.creator.name).to eq 'Paul'
  end

  it 'user1 creates an event and adds user2 to event\'s attendees' do
    user1 = User.find(1)
    user1.events.create(description: 'Event one', location: 'Home', event_date: '2020-12-31')

    user2 = User.find(2)
    event = Event.find(1)

    user2.attended_events.push(event)

    expect(event.attendees[0].name).to eq 'Sum'
  end
end
