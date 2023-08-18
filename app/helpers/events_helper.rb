module EventsHelper
    def liste_events(division)
        Event.where(division_id: division)
    end
end
