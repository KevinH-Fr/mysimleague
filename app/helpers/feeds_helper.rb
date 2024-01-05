module FeedsHelper

    def feeds_elements
        # Define the models you want to fetch
        models_to_fetch = 
        [User, AssociationUser, Event, Resultat, Doi, Pari, Dotd, Presence,
            Ligue, Saison, Division, Circuit, Equipe, Purchase ]

        @feeds = []
      
        models_to_fetch.each do |model|

            recent_records = model.order(updated_at: :desc)

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
            content_tag :i, "", class: "fa fa-2x fa-road me-2 text-light"
        when "Equipe"
            content_tag :i, "", class: "fa fa-2x fa-car me-2 text-light"
        when "Event"
            content_tag :i, "", class: "fa fa-2x fa-calendar-check me-2"
        when "Resultat"
            content_tag :i, "", class: "fa fa-2x fa-square-poll-horizontal text-primary me-2"
        when "Pari"
            content_tag :i, "", class: "fa fa-2x fa-money-bill-wave text-success me-2"
        when "User"
            content_tag :i, "", class: "fa fa-2x fa-user text-light me-2"
        when "AssociationUser"
            content_tag :i, "", class: "fa fa-2x fa-user text-light me-2"
        when "Doi"
            content_tag :i, "", class: "fa fa-2x fa-solid fa-magnifying-glass text-danger me-2"
        when "Dotd"
            content_tag :i, "", class: "fa fa-2x fa-solid fa-ranking-star text-primary me-2"
        when "Presence"
            content_tag :i, "", class: "fa fa-2x fa-solid fa-street-view text-warning me-2"

        when "Purchase"
                crown_color = case feed.article.niveau
                            when 1 then "brown"
                            when 2 then "grey"
                            when 3 then "yellow"
                            else "blue"
                            end
            
                content_tag :i, "", class: "fa fa-2x fa-solid fa-crown me-2 fa-fade", style: "color: #{crown_color};"
          

        else
            content_tag :i, "", class: "fa fa-xl fa-question-circle text-dark me-2"
        end 
    end

    def feed_label(feed)
        case feed.class.name
        when "Ligue"
            span_label = content_tag(:span, "Ligue")
            span_content = content_tag(:span, feed.nom, class: "fw-bold mx-2")
            combined_content = span_label + " " + span_content
        when "Saison"
            span_label = content_tag(:span, "Saison")
            span_content = content_tag(:span, feed.nom, class: "fw-bold mx-2")
            combined_content = span_label + " " + span_content
        when "Division"
            span_label = content_tag(:span, "Division")
            span_content = content_tag(:span, feed.nom, class: "fw-bold mx-2")
            combined_content = span_label + " " + span_content
        when "Circuit"
            span_label = content_tag(:span, "Circuit")
            span_content = content_tag(:span, feed.short_name, class: "fw-bold mx-2")
            combined_content = span_label + " " + span_content
        when "Equipe"
            span_label = content_tag(:span, "Equipe")
            span_content = content_tag(:span, feed.nom, class: "fw-bold mx-2")
            combined_content = span_label + " " + span_content
        when "Event"
            span_label = content_tag(:span, "Event")
            span_content = content_tag(:span, truncate(feed.circuit.nom, length: 18), class: "fw-bold mx-2")

            combined_content = span_label + " " + span_content
        when "Resultat"
            span_label = content_tag(:span, "Resultat")
            span_content = content_tag(:span, feed.association_user.user.short_name, class: "fw-bold mx-1")
            span_image = image_tag(feed.association_user.user.webp_variant, class: "mini-profile-pic mx-2", alt: "user picture")
   
            span_icon_parieur = icon_leader_parieur(feed.association_user.user.id)
            span_icon_leader_user = icon_leader_user(feed.association_user.user.id)
            span_icon_leader_pilote = icon_leader_pilote(feed.association_user.user.id)
            span_icon_abonne =  user_paid_purchases_icon(feed.association_user.user)

            combined_content = span_label + span_image  + " " + span_content +  span_icon_parieur +  span_icon_leader_user + span_icon_leader_pilote + span_icon_abonne
        when "Pari"
            span_label = content_tag(:span, "Pari")
            span_content = content_tag(:span, feed.user.nom, class: "fw-bold mx-1")
            span_image = image_tag(feed.user.webp_variant, class: "mini-profile-pic mx-2", alt: "user picture")
        
            span_icon_parieur = icon_leader_parieur(feed.user.id)
            span_icon_leader_user = icon_leader_user(feed.user.id)
            span_icon_leader_pilote = icon_leader_pilote(feed.user.id)
            span_icon_abonne =  user_paid_purchases_icon(feed.user)

            combined_content = span_label + span_image  + " " + span_content +  span_icon_parieur +  span_icon_leader_user + span_icon_leader_pilote + span_icon_abonne

        when "User"

            if feed.present? 
                span_label = content_tag(:span, "User")
                span_content = content_tag(:span, feed.short_name, class: "fw-bold mx-1")
                span_image = image_tag(feed.webp_variant, class: "mini-profile-pic mx-2", alt: "user picture")
                
                span_icon_parieur = icon_leader_parieur(feed.id)
                span_icon_leader_user = icon_leader_user(feed.id)
                span_icon_leader_pilote = icon_leader_pilote(feed.id)
                span_icon_abonne =  user_paid_purchases_icon(feed)

                combined_content = span_label + span_image + " " + span_content + span_icon_parieur +  span_icon_leader_user + span_icon_leader_pilote + span_icon_abonne
            end 
        when "AssociationUser"
            span_label = content_tag(:span, "Pilote")
            span_content = content_tag(:span, feed.user.short_name, class: "fw-bold mx-1")
            span_image = image_tag(feed.user.webp_variant, class: "mini-profile-pic mx-2", alt: "user picture")

            span_icon_parieur = icon_leader_parieur(feed.user.id)
            span_icon_leader_user = icon_leader_user(feed.user.id)
            span_icon_leader_pilote = icon_leader_pilote(feed.user.id)
            span_icon_abonne =  user_paid_purchases_icon(feed.user)

            combined_content = span_label  + span_image  + " " + span_content + span_icon_parieur +  span_icon_leader_user + span_icon_leader_pilote  + span_icon_abonne

        when "Doi"
            span_label = content_tag(:span, "DOI")
            if feed.demandeur_id.present?
                span_content = content_tag(:span, AssociationUser.find(feed.demandeur_id).user.short_name, class: "fw-bold")
                span_image = image_tag(AssociationUser.find(feed.demandeur_id).user.webp_variant, class: "mini-profile-pic mx-2", alt: "user picture")

                span_icon_parieur = icon_leader_parieur(AssociationUser.find(feed.demandeur_id).user.id)
                span_icon_leader_user = icon_leader_user(AssociationUser.find(feed.demandeur_id).user.id)
                span_icon_leader_pilote = icon_leader_pilote(AssociationUser.find(feed.demandeur_id).user.id)
                span_icon_abonne =  user_paid_purchases_icon(AssociationUser.find(feed.demandeur_id).user)

            else
                span_content = content_tag(:span, "Commissaire", class: "fw-bold")
                span_image =  content_tag(:i, "", class: "fa fa-xl fa-person-military-pointing mx-2")
            end 
            combined_content = span_label + span_image +  " " + span_content  + span_icon_parieur +  span_icon_leader_user + span_icon_leader_pilote + span_icon_abonne

        when "Dotd"
            span_label = content_tag(:span, "DOTD")
            span_content = content_tag(:span, feed.user.short_name, class: "fw-bold me-1")
            span_image = image_tag(feed.user.webp_variant, class: "mini-profile-pic mx-2", alt: "user picture")

            span_icon_parieur = icon_leader_parieur(feed.user.id)
            span_icon_leader_user = icon_leader_user(feed.user.id)
            span_icon_leader_pilote = icon_leader_pilote(feed.user.id)
            span_icon_abonne =  user_paid_purchases_icon(feed.user)

            combined_content = span_label + span_image + " " + span_content + " " + span_icon_parieur +  span_icon_leader_user + span_icon_leader_pilote + span_icon_abonne

        when "Presence"
            span_label = content_tag(:span, "Presence")
            span_content = content_tag(:span, feed.association_user.user.short_name, class: "fw-bold me-1")
            span_image = image_tag(feed.association_user.user.webp_variant, class: "mini-profile-pic mx-2", alt: "user picture")
            
            span_icon_parieur = icon_leader_parieur(feed.association_user.user.id)
            span_icon_leader_user = icon_leader_user(feed.association_user.user.id)
            span_icon_leader_pilote = icon_leader_pilote(feed.association_user.user.id)
            span_icon_abonne =  user_paid_purchases_icon(feed.association_user.user)
 
            combined_content = span_label + span_image + " " + span_content + span_icon_parieur +  span_icon_leader_user + span_icon_leader_pilote + span_icon_abonne
            
        when "Purchase"
                span_label = content_tag(:span, "Abonné")
                span_content = content_tag(:span, feed.user.short_name, class: "fw-bold mx-1")
                span_image = image_tag(feed.user.webp_variant, class: "mini-profile-pic mx-2", alt: "user picture")
                
                span_icon_parieur = icon_leader_parieur(feed.user.id)
                span_icon_leader_user = icon_leader_user(feed.user.id)
                span_icon_leader_pilote = icon_leader_pilote(feed.user.id)
                span_icon_abonne =  user_paid_purchases_icon(feed.user)

                combined_content = span_label + span_image + " " + span_content + span_icon_parieur +  span_icon_leader_user + span_icon_leader_pilote + span_icon_abonne
        else
            span_label = content_tag(:span, "Model")
            span_content = content_tag(:span, feed, class: "fw-bold")
            combined_content = span_label + " " + span_content
        end 
            
    end

    def feed_path(feed)            

        case feed.class.name
        when "Resultat", "Pari", "Doi", "Dotd", "Presence"
          menu_index_path(ligue: feed.event.division.saison.ligue, saison: feed.event.division.saison, division: feed.event.division_id, event: feed.event_id)
        when "Event"
            menu_index_path(ligue: feed.division.saison.ligue, saison: feed.division.saison, division: feed.division_id, event: feed)
        when "User"
          user_path(feed) 
        when "AssociationUser"
          user_path(feed.user_id)
        when "Ligue"
            menu_index_path(ligue: feed)
        when "Saison"
            menu_index_path(ligue: feed.ligue_id, saison: feed)
        when "Division"
            menu_index_path(ligue: feed.saison.ligue, saison: feed.saison_id, division: feed)  
        when "Equipe"
            equipe_path(feed)  
        when "Circuit"
            circuit_path(feed) 
        when "Purchase"
            abonnements_path() 
        else
          root_path
        end
      end




  end
  