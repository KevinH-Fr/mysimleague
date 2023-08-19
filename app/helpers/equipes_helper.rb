module EquipesHelper
    def equipe_banner_with_pilote(equipe, pilote)
      if equipe.banniere.present?
        image_tag = image_tag(equipe.banniere, 
          class: "position-relative rounded m-0 p-0 img-fluid",
          style: "object-fit: cover; width: 100%; height: 100%; object-position: left;")
        
        pilote_span = content_tag(:span, pilote, 
            class: "text-light fw-bold fs-5 position-absolute top-50 start-0 translate-middle-y",
            style: "margin-left: 180px;") # Adjust the value as needed
        
        [image_tag, pilote_span].join.html_safe
      end
    end
# margin differente pour documents
def equipe_banner_with_pilote_document(equipe, pilote)
  if equipe.present?
    common_attributes = {
      class: "position-relative rounded m-0 p-0 img-fluid",
      style: "object-fit: cover; width: 100%; height: 100%; object-position: left;"
    }

    image_tag = case equipe.nom
                when "Ferrari"
                  image_tag(asset_url('/images/equipes/fer.png'), common_attributes)
                when "Mercedes"
                  image_tag(asset_url('/images/equipes/mer.png'), common_attributes)
                when "RedBull"
                  image_tag(asset_url('/images/equipes/red.png'), common_attributes)
                when "McLaren"
                  image_tag(asset_url('/images/equipes/mcl.png'), common_attributes)
                else
                  image_tag(asset_url('/images/equipes/def.png'), common_attributes)
                end
    
    pilote_span = content_tag(:span, pilote,
                              class: "text-light fw-bold fs-5 position-absolute",
                              style: "left: 120px; top: 15px; transform: translate(-50%, -50%); z-index: 1;") # Adjust the values as needed
        
    [image_tag, pilote_span].join.html_safe
  end
end

    
    

    def equipe_banner_without_pilote(equipe)
      if equipe.banniere.present?
        image_tag = image_tag(equipe.banniere, 
          class: "position-relative rounded m-0 p-0 img-fluid",
          style: "object-fit: cover; width: 100%; height: 100%; object-position: left;")
        
        equipe_span = content_tag(:span, equipe.nom, 
            class: "text-light fw-bold position-absolute top-50 start-0 translate-middle-y",
            style: "margin-left: 300px;") # Adjust the value as needed
        
        [image_tag, equipe_span].join.html_safe
      end
    end

    def equipe_banner_without_pilote_document(equipe)
      if equipe.banniere.present?
        image_tag = image_tag(equipe.banniere, 
          class: "position-relative rounded m-0 p-0 img-fluid",
          style: "object-fit: cover; width: 100%; height: 100%; object-position: left;")
        
        equipe_span = content_tag(:span, equipe.nom, 
          class: "text-light fw-bold fs-5 position-absolute",
            style: "left: 140px; top: 0px; z-index: 1;") # Adjust the values as needed  
        
        [image_tag, equipe_span].join.html_safe
      end
    end


  end
  