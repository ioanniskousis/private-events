class EventsController < ApplicationController
  # before_action :set_event, only: [:show, :edit, :update, :destroy]
  before_action :require_login

  # GET /events
  # GET /events.json
  def index
    # @upcoming_events = Event.upcoming_events.sort_by { |e| e.event_date }
    # @previous_events = Event.previous_events.sort_by { |e| e.event_date }
    @upcoming_events = Event.future_events(Time.now).sort_by { |e| e.event_date }
    @previous_events = Event.past_events(Time.now).sort_by { |e| e.event_date }
  end

  # GET /events/1
  # GET /events/1.json
  def show
    @users = User.all
    @event = Event.find(params[:id])
    @register_label = User.find(session[:user_id]).attended_events.include?(@event) ? "Unregister From The Event" : "Join The Event"
    @button_class = User.find(session[:user_id]).attended_events.include?(@event) ? "bg_red w300" : "bg_green w200"
  end

  # GET /events/new
  def new
    @user = User.find(session[:user_id])
    @event = @user.events.build
    @event.event_date = Time.now
  end

  # GET /events/1/edit
  def edit
    @event = Event.find(params[:id])
  end

  # POST /events
  # POST /events.json
  def create
    # @event = Event.new(event_params)
    @user = User.find(session[:user_id])
    @event = @user.events.build(event_params)

    if @event.save
      @event.attendees.push(@user)
      redirect_to events_path, notice: 'Event was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /events/1
  # PATCH/PUT /events/1.json
  def update
    set_event
    if @event.update(event_params)
      redirect_to event_path(@event.id), notice: 'Event was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    set_event
    @event.destroy
    redirect_to events_path, notice: 'Event was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def event_params
      params.require(:event).permit(:description, :location, :event_date)
    end

    def require_login
      # session[:user_id] = nil
      if session[:user_id]
        true
      else
        redirect_to new_session_path
        false
      end
    end
end
