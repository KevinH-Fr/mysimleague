module FeedsHelper
    # selecteur d'icon pour le feed en fonction du model
    def icon(feed)
        case feed.class.name
        when "Pilote"
            content_tag :i, "", class: "fa fa-user"
        when "Ligue"
            content_tag :i, "", class: "fa fa-people-group"
        when "Saison"
            content_tag :i, "", class: "fa fa-arrows-spin"
        when "Division"
            content_tag :i, "", class: "fa fa-layer-group"
        when "Circuit"
            content_tag :i, "", class: "fa fa-road"
        when "Equipe"
            content_tag :i, "", class: "fa fa-car"
        when "Event"
            content_tag :i, "", class: "fa fa-calendar-check"
        when "Resultat"
            content_tag :i, "", class: "fa fa-square-poll-horizontal"

        else
            content_tag :i, "", class: "fa fa-question-circle"
        end 
    end
  end
  