class EventsController < ApplicationController
  def new
  end

  def create
    @event = Event.create(event_params)
    @event.guests << current_user
    @event.save
    redirect_to event_path(@event) 
  end

  def edit
  end

  def update
  end

  def index
  end

  def show
    @event = Event.find(params[:id])
  end

  def destroy
  end

  def guest
    event = Event.find(params[:id])
    current_user
    if event.guests.include?(@current_user)
      redirect_to event_path(event)
    else
      event.guests << user
      event.save
      redirect_to event_path(event)
    end    
  end

  private

  def event_params
    params.require(:event).permit(:name, :date, :host_id)
  end
end
