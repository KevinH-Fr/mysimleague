module ButtonsHelper
    def custom_submit_button(text)
        content_tag(:div, class: "container-fluid m-0 p-0 text-end") do
            button_tag(type: "submit", class: "btn btn-sm bg-success text-light fw-bold") do
                concat content_tag(:i, "", class: "fa-solid fa-xl fa-check-circle me-2")
                concat text
            end
        end
    end

    def back_button_on_event(event)
        event = Event.find(event)
        content_tag(:div, class: "container-fluid my-1 p-0 text-start") do
            link_to menu_index_path(
                ligue: event.division.saison.ligue, 
                saison: event.division.saison,
                division: event.division,
                event: event), 
                class: "btn btn-sm bg-dark text-light fw-bold" do
              content_tag(:i, "", class: "fa-solid fa-xl fa-rotate-left me-2") + "Back"
            end
        end
    end

end
  