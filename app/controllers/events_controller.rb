class EventsController < ApplicationController
  def new
  end

  def create
    @event = Event.create(event_params)
    @event.guests << current_user
    @event.create_playlist
    @event.save
    redirect_to event_path(@event) 
  end

  def edit
  end

  def update
  end

  def index
    @events = Event.all
  end

  def show
    @event = Event.find(params[:id])
  end

  def destroy
  end

  def guest
    event = Event.find(params[:id])
    current_user
    byebug
    if event.guests.include?(@current_user)
      redirect_to event_path(event)
    else
      event.guests << @current_user
      event.save
      byebug
      event.add_songs(@current_user)
      redirect_to event_path(event)
    end    
  end

  private

  def event_params
    params.require(:event).permit(:name, :date, :host_id)
  end
end
