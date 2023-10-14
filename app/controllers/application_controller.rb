class ApplicationController < ActionController::Base

    include Pagy::Backend

    before_action :record_page_view
    around_action :set_time_zone, if: -> { session[:ligue].present? }

    before_action :track_action

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
    
    private

    def track_action
        if current_user
            current_user.increment!(:action_count)
        end 
    end

    def set_time_zone
        Time.use_zone(Ligue.find(session[:ligue]).time_zone) {yield}
    end

end
