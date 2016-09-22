class EventController < ApplicationController
  def new
  end

  def create
    @event = Event.create(event_params)
  end

  def edit
  end

  def update
  end

  def index
  end

  def show
  end

  def destroy
  end


  def event_params
    params.require(:event).permit(:name, :date, :host_id)
  end
end
