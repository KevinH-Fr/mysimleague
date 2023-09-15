module FeedsHelper

    def feeds_elements
        # Define the models you want to fetch
        models_to_fetch = [User, AssociationUser, Ligue, Saison, Division, Circuit, Equipe, Event, Resultat, Doi, Pari, Dotd]
      
        # Initialize an empty array to store the results
        @feeds = []
      
        # Iterate through the models and fetch the most recent 3 records for each
        models_to_fetch.each do |model|
          # Use the 'or' method to build a query for each model
          recent_records = model.order(updated_at: :desc).limit(3)
          @feeds += recent_records
        end
      
        # Sort @feeds by updated_at in descending order
        @feeds.sort_by!(&:updated_at).reverse!
    end
      
    # selecteur d'icon pour le feed en fonction du model
    def feed_icon(feed)
        case feed.class.name
        when "Pilote"
            content_tag :i, "", class: "fa fa-2x fa-user me-2", style: "color: blue;"
        when "Ligue"
            content_tag :i, "", class: "fa fa-2x fa-people-group text-warning me-2"
        when "Saison"
            content_tag :i, "", class: "fa fa-2x fa-arrows-spin me-2", style: "color: orange;"
        when "Division"
            content_tag :i, "", class: "fa fa-2x fa-layer-group me-2", style: "color: grey;"
        when "Circuit"
            content_tag :i, "", class: "fa fa-2x fa-road me-2", style: "color: grey;"
        when "Equipe"
            content_tag :i, "", class: "fa fa-2x fa-car me-2", style: "color: blue;"
        when "Event"
            content_tag :i, "", class: "fa fa-2x fa-calendar-check me-2"
        when "Resultat"
            content_tag :i, "", class: "fa fa-2x fa-square-poll-horizontal text-primary me-2"
        when "Pari"
            content_tag :i, "", class: "fa fa-2x fa-money-bill-wave text-success me-2"
        when "User"
            content_tag :i, "", class: "fa fa-2x fa-user text-warning me-2"
        when "AssociationUser"
            content_tag :i, "", class: "fa fa-2x fa-user text-warning me-2"
        when "Doi"
            content_tag :i, "", class: "fa fa-2x fa-solid fa-magnifying-glass text-danger me-2"
        when "Dotd"
            content_tag :i, "", class: "fa fa-2x fa-solid fa-ranking-star text-warning me-2"

        else
            content_tag :i, "", class: "fa fa-xl fa-question-circle text-dark me-2"
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
            span_content = content_tag(:span, feed.short_name, class: "fw-bold")
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
            span_content = content_tag(:span, feed.association_user.user.short_name, class: "fw-bold")
            span_image = image_tag(feed.association_user.user.webp_variant, class: "mini-profile-pic ms-1", alt: "user picture")
            combined_content = span_label + span_image + " " + span_content
        when "Pari"
            span_label = content_tag(:span, "Pari")
            span_content = content_tag(:span, feed.user.nom, class: "fw-bold")
            span_image = image_tag(feed.user.webp_variant, class: "mini-profile-pic ms-1", alt: "user picture")
            combined_content = span_label + span_image + " " + span_content
        when "User"
            span_label = content_tag(:span, "User")
            span_content = content_tag(:span, feed.short_name, class: "fw-bold")
            span_image = image_tag(feed.webp_variant, class: "mini-profile-pic ms-1", alt: "user picture")
            combined_content = span_label + span_image + " " + span_content 
        when "AssociationUser"
            span_label = content_tag(:span, "Pilote")
            span_content = content_tag(:span, feed.user.short_name, class: "fw-bold")
            span_image = image_tag(feed.user.webp_variant, class: "mini-profile-pic ms-1", alt: "user picture")
            combined_content = span_label  + span_image  + " " + span_content


        when "Doi"
            span_label = content_tag(:span, "DOI")
            if feed.demandeur_id.present?
                span_content = content_tag(:span, AssociationUser.find(feed.demandeur_id).user.short_name, class: "fw-bold")
                span_image = image_tag(AssociationUser.find(feed.demandeur_id).user.webp_variant, class: "mini-profile-pic ms-1", alt: "user picture")
            else
                span_content = content_tag(:span, "Commissaire", class: "fw-bold")
                span_image =  content_tag(:i, "", class: "fa fa-xl fa-person-military-pointing mx-2")
            end 
            combined_content = span_label + span_image + " " + span_content

        when "Dotd"
            span_label = content_tag(:span, "DOTD")
            span_content = content_tag(:span, feed.user.short_name, class: "fw-bold")
            span_image = image_tag(feed.user.webp_variant, class: "mini-profile-pic ms-1", alt: "user picture")
            combined_content = span_label + span_image + " " + span_content

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
        when "Dotd"
            menu_index_path(ligue: feed.event.division.saison.ligue, saison: feed.event.division.saison, division: feed.event.division_id, event: feed.event_id)  

        else
          root_path
        end
      end
      
    

  end
  