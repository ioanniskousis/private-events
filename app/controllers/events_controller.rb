class EventsController < ApplicationController
  # before_action :set_event, only: [:show, :edit, :update, :destroy]
  before_action :require_login

  # GET /events
  # GET /events.json
  def index
    @events = Event.all
    # find_by_sql("SELECT events.*, users.name FROM events INNER JOIN users ON events.user_id = users.id")
  end

  # GET /events/1
  # GET /events/1.json
  def show
    @event = Event.find(params[:id])
  end

  # GET /events/new
  def new
    @user = User.find(session[:user_id])
    @event = @user.events.build
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

    respond_to do |format|
      if @event.save
        format.html { redirect_to events_path, notice: 'Event was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /events/1
  # PATCH/PUT /events/1.json
  def update
    set_event
    if @event.update(event_params)
      redirect_to events_path, notice: 'Event was successfully updated.'
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
      params.require(:event).permit(:description)
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
