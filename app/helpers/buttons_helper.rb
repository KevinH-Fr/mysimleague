module ButtonsHelper
    def custom_submit_button(text)
        content_tag(:div, class: "container-fluid m-0 p-0 text-end") do
            button_tag(type: "submit", class: "btn btn-sm bg-success text-light fw-bold") do
                concat content_tag(:i, "", class: "fa-solid fa-xl fa-check-circle me-2")
                concat text
            end
        end
    end

    def custom_submit_search_button
        content_tag(:div, class: "container-fluid m-0 p-0 text-end") do
            button_tag(type: "submit", class: "btn btn-sm bg-success text-light fw-bold") do
                concat content_tag(:i, "", class: "fa-solid fa-xl fa-magnifying-glass-arrow-right")
            end
        end
    end

    def back_button_on_event(event)
        event = Event.find(event)
        content_tag(:div, class: "m-1") do
            link_to menu_index_path(
                ligue: event.division.saison.ligue, 
                saison: event.division.saison,
                division: event.division,
                event: event), 
                class: "btn btn-sm bg-dark text-light fw-bold" do
              content_tag(:i, "", class: "fa-solid fa-xl fa-rotate-left")
            end
        end
    end

    def add_disabled_button
        content_tag(:button, class: 'btn btn-sm btn-secondary m-2', type: 'button', disabled: true) do
          content_tag(:i, nil, class: 'fa-solid fa-square-plus fa-xl')
        end
    end


    def back_button_root
        content_tag(:div, class: "m-1 d-flex align-items-center") do
            link_to root_path, class: "w-25 btn btn-sm bg-dark text-light fw-bold d-flex align-items-center" do
                content_tag(:i, "", class: "fa-solid fa-xl fa-home") +
                content_tag(:span, "Home", class: "ms-2")
            end
        end
    end

    def back_button_setup_dashboard
        content_tag(:div, class: "m-1 d-flex align-items-center") do
            link_to setup_dashboard_path, class: "w-25 btn btn-sm bg-dark text-light fw-bold d-flex align-items-center" do
              content_tag(:i, "", class: "fa-solid fa-xl fa-toolbox") +
              content_tag(:span, "SetupTool", class: "ms-2")
            end
        end
          
    end
    
end
