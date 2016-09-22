class EventsController < ApplicationController
  def new
  end

  def create
    @event = Event.create(event_params)
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


  def event_params
    params.require(:event).permit(:name, :date, :host_id)
  end
end
