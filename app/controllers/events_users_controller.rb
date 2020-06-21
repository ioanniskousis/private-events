class EventsUsersController < ApplicationController
  def show
    @event = Event.find(params[:id])
    @users = User.all
  end

  def create
    @event = Event.find(params[:event_id])
    @invited_user = User.find(params[:user_id])

    if @event.attendees.include?(@invited_user)
      @invited_user.attended_events.delete(@event)
      flash.notice = 'Uninvited ' + @invited_user.name + ' from ' + @event.description
    else
      @invited_user.attended_events.push(@event)
      flash.notice = 'Invited ' + @invited_user.name + ' to ' + @event.description
    end

    redirect_to event_path(@event.id)
  end
end
