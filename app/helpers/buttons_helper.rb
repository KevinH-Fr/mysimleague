module ButtonsHelper
    def custom_submit_button(text)
        content_tag(:div, class: "container-fluid m-0 p-0 text-end") do
            button_tag(type: "submit", class: "btn btn-sm bg-success text-light fw-bold") do
                concat content_tag(:i, "", class: "fa-solid fa-xl fa-check-circle me-2")
                concat text
            end
        end
    end
end
  