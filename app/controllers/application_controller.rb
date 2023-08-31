class ApplicationController < ActionController::Base

    before_action :record_page_view
  
    def record_page_view
      ActiveAnalytics.record_request(request)
    end
  
    
    def event_courant 
        if params[:event]
            @event = Event.find(params[:event]) 
        end
    end

    def previous_event 
        if params[:event]
            Event.where(division_id: @event.division_id, numero: @event.numero - 1).first
        end
    end

    def division_courante 
        if params[:event]
            @event = Event.find(params[:event])
            Division.find(@event.division_id)
        end
    end




end
