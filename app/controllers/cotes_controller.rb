class CotesController < ApplicationController
  def index
    if params[:event]
      @event_n = Event.find(params[:event]) 
    end
  end
end
