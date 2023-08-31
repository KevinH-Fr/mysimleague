module FeedsHelper

    def feeds_elements

        feed_users = User.order(updated_at: :desc).limit(5)
        feed_association_users =  AssociationUser.order(updated_at: :desc).limit(5)
        feed_ligues =  Ligue.order(updated_at: :desc).limit(5)
        feed_saisons =  Saison.order(updated_at: :desc).limit(5)
        feed_divisions =  Division.order(updated_at: :desc).limit(5)
    
        feed_circuits =  Circuit.order(updated_at: :desc).limit(5)
        feed_ecuries =  Equipe.order(updated_at: :desc).limit(5)
        feed_events =  Event.order(updated_at: :desc).limit(5)
        feed_resultats =  Resultat.order(updated_at: :desc).limit(5)
        feed_dois =  Doi.order(updated_at: :desc).limit(5)

        feed_paris =  Pari.order(updated_at: :desc).limit(5)
 
        @feeds = []
        @feeds.concat(feed_users)
        @feeds.concat(feed_association_users)

        @feeds.concat(feed_ligues)
        @feeds.concat(feed_saisons)
        @feeds.concat(feed_divisions)
    
        @feeds.concat(feed_circuits)
        @feeds.concat(feed_ecuries)
        @feeds.concat(feed_events)
        @feeds.concat(feed_resultats)
        @feeds.concat(feed_dois)

        @feeds.concat(feed_paris)
   
        @feeds.sort_by!(&:updated_at).reverse!
        
    end
    # selecteur d'icon pour le feed en fonction du model
    def feed_icon(feed)
        case feed.class.name
        when "Pilote"
            content_tag :i, "", class: "fa fa-xl fa-user", style: "color: blue;"
        when "Ligue"
            content_tag :i, "", class: "fa fa-xl fa-people-group text-warning"
        when "Saison"
            content_tag :i, "", class: "fa fa-xl fa-arrows-spin", style: "color: orange;"
        when "Division"
            content_tag :i, "", class: "fa fa-xl fa-layer-group", style: "color: grey;"
        when "Circuit"
            content_tag :i, "", class: "fa fa-xl fa-road", style: "color: grey;"
        when "Equipe"
            content_tag :i, "", class: "fa fa-xl fa-car", style: "color: blue;"
        when "Event"
            content_tag :i, "", class: "fa fa-xl fa-calendar-check"
        when "Resultat"
            content_tag :i, "", class: "fa fa-xl fa-square-poll-horizontal text-primary"
        when "Pari"
            content_tag :i, "", class: "fa fa-xl fa-money-bill-wave text-success"
        when "User"
            content_tag :i, "", class: "fa fa-xl fa-user text-warning"
        when "AssociationUser"
            content_tag :i, "", class: "fa fa-xl fa-user text-warning"
        when "Doi"
            content_tag :i, "", class: "fa fa-xl fa-solid fa-magnifying-glass text-danger"
        else
            content_tag :i, "", class: "fa fa-xl fa-question-circle text-dark"
        end 
    end

    def feed_label(feed)
        case feed.class.name
        when "Ligue"
            span_label = content_tag(:span, "Ligue")
            span_content = content_tag(:span, feed.nom, class: "fw-bold")
            combined_content = span_label + " " + span_content
        when "Saison"
            span_label = content_tag(:span, "Saison")
            span_content = content_tag(:span, feed.nom, class: "fw-bold")
            combined_content = span_label + " " + span_content
        when "Division"
            span_label = content_tag(:span, "Division")
            span_content = content_tag(:span, feed.nom, class: "fw-bold")
            combined_content = span_label + " " + span_content
        when "Circuit"
            span_label = content_tag(:span, "Circuit")
            span_content = content_tag(:span, feed.nom, class: "fw-bold")
            combined_content = span_label + " " + span_content
        when "Equipe"
            span_label = content_tag(:span, "Equipe")
            span_content = content_tag(:span, feed.nom, class: "fw-bold")
            combined_content = span_label + " " + span_content
        when "Event"
            span_label = content_tag(:span, "Event")
            span_content = content_tag(:span, feed.circuit.nom, class: "fw-bold")
            combined_content = span_label + " " + span_content
        when "Resultat"
            span_label = content_tag(:span, "Resultat")
            span_content = content_tag(:span, feed.association_user.user.nom, class: "fw-bold")
            combined_content = span_label + " " + span_content
        when "Pari"
            span_label = content_tag(:span, "Pari")
            span_content = content_tag(:span, feed.user.nom, class: "fw-bold")
            combined_content = span_label + " " + span_content
        when "User"
            span_label = content_tag(:span, "User")
            span_content = content_tag(:span, feed.nom, class: "fw-bold")
            combined_content = span_label + " " + span_content
        when "AssociationUser"
            span_label = content_tag(:span, "Pilote")
            span_content = content_tag(:span, feed.user.nom, class: "fw-bold")
            combined_content = span_label + " " + span_content
        when "Doi"
            span_label = content_tag(:span, "DOI")
            span_content = content_tag(:span, AssociationUser.find(feed.demandeur_id).user.nom, class: "fw-bold")
            combined_content = span_label + " " + span_content

        else
            span_label = content_tag(:span, "Model")
            span_content = content_tag(:span, feed, class: "fw-bold")
            combined_content = span_label + " " + span_content
        end 
    end

    def feed_path(feed)
        case feed.class.name
        when "Ligue"
            menu_index_path(ligue: feed)
        when "Saison"
            menu_index_path(ligue: feed.ligue_id, saison: feed)
        when "Division"
            menu_index_path(ligue: feed.saison.ligue, saison: feed.saison_id, division: feed)  
        when "Event"
            menu_index_path(ligue: feed.division.saison.ligue, saison: feed.division.saison, division: feed.division_id, event: feed)  
        when "Equipe"
            equipe_path(feed)  
        when "Circuit"
            circuit_path(feed)  
        when "Resultat"
            menu_index_path(ligue: feed.event.division.saison.ligue, saison: feed.event.division.saison, division: feed.event.division_id, event: feed.event_id)  
        when "Pari"
            menu_index_path(ligue: feed.event.division.saison.ligue, saison: feed.event.division.saison, division: feed.event.division_id, event: feed.event_id)  
        when "User"
            user_path(feed)
        when "AssociationUser"
            user_path(feed.user_id)
        when "Doi"
            menu_index_path(ligue: feed.event.division.saison.ligue, saison: feed.event.division.saison, division: feed.event.division_id, event: feed.event_id)  
        else
          root_path
        end
      end
      
    

  end
  