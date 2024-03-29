module EquipesHelper

    #new banner unique pour faciliter gestion image 
    def equipe_banner_with_data(equipe, label, user)
      if equipe.banniere.present?
        image_tag = image_tag(equipe.banniere, 
          class: "position-relative rounded m-0 p-0 img-fluid max-record-height",
          style: "object-fit: cover; object-position: left center;")
        
        truncated_label = truncate(label, length: 14) 

        label_span = content_tag(:span, truncated_label, 
            class: "text-banniere position-absolute top-50 start-0 translate-middle-y",
            style: "margin-left: 70px;") # Adjust the value as needed
        
        content_tag(:div, class: "equipe-banner-wrapper", style: "position: relative;") do

          if user.present?
            link_to(user_path(user)) do
              [image_tag, label_span].join.html_safe
            end 
          else 
            [image_tag, label_span].join.html_safe
          end

        end
      end

    end


  # margin differente pour documents
    def equipe_banner_with_data_document(equipe, label)
      if equipe.banniere.present?
        image_tag = cl_image_tag(equipe.banniere.url, 
          class: "position-relative rounded m-0 p-0 img-fluid",
          style: "object-fit: cover; width: 100%; height: 100%; object-position: left;")
        
          truncated_label = truncate(label, length: 20) # Adjust the length as needed
    
          label_span = content_tag(:span, truncated_label, 
            class: "text-light fw-bold fs-5 position-absolute start-0",
            style: "margin-left: 100px;") # Adjust the value as needed
                  
            content_tag(:div, class: "img-banniere-doc", style: "position: relative;")  do
              [image_tag, label_span].join.html_safe
            end

          end
    end

    def equipes_division(division)
      association_users = AssociationUser.includes(:user)
      .where(
        division_id: division,
        actif: true,
        valide: true
      )

      equipe_ids = association_users.pluck(:equipe_id).uniq
      equipes = Equipe.where(id: equipe_ids)

      equipes

    end
    

  end
  