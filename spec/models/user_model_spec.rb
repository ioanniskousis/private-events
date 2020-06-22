require 'rails_helper'

RSpec.describe 'Usern Model', type: :model do
  before :each do
    User.create(name: 'User 2')
    User.create(name: 'User 1')
  end

  it 'loads users ordered by their name' do
    user1 = User.find(1)
    user2 = User.find(2)

    expect(User.order(:name)).to eq([user2, user1])
  end

  it 'each user creates 1 event' do
    user1 = User.find(1)
    user2 = User.find(2)

    user1.events.create(description: 'Event one', location: 'Home', event_date: '2020-12-31')
    user2.events.create(description: 'Event two', location: 'Pub', event_date: '2021-12-31')

    expect(Event.all.count).to eq 2
    expect(User.all.count).to eq 2
  end

  it 'destoys 2 users and their created events' do
    user1 = User.find(1)
    user2 = User.find(2)

    user1.events.create(description: 'Event one', location: 'Home', event_date: '2020-12-31')
    user2.events.create(description: 'Event two', location: 'Pub', event_date: '2021-12-31')

    user1.destroy
    user2.destroy

    expect(Event.all.count).to eq 0
    expect(User.all.count).to eq 0
  end

  it 'updates user2 name' do
    user1 = User.find(1)
    user2 = User.find(2)
    user2.name = 'user 3'
    user2.save

    expect(User.order(:name)).to eq([user1, user2])
  end

  it 'user1 joins \'Event two\'' do
    user1 = User.find(1)
    user2 = User.find(2)
    user2.events.create(description: 'Event two', location: 'Pub', event_date: '2021-12-31')

    user1.attended_events.push(user2.events[0])

    expect(user1.attended_events[0].description).to eq('Event two')
  end
end
