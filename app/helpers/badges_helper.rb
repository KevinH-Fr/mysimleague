module BadgesHelper

  def status_badge(value)
    if value || value == "fait_de_course"
      content_tag(:span, "valide", class: "badge bg-success")
    else
      content_tag(:span, "non-valide", class: "badge bg-danger")
    end
  end

  def activity_badge(value)
    if value
      content_tag(:span, "actif", class: "badge bg-success")
    else
      content_tag(:span, "inactif", class: "badge bg-danger")
    end
  end

  def boolean_badge(value)
    if value > 0
      content_tag(:span, number_with_delimiter(value.to_i, delimiter: ' ', precision: 0), class: "badge bg-success")
    end
  end

  def boolean_icon(value)
    content_tag(:span, class: "container-fluid text-light fw-bold") do
      content_tag(:i, "", class: "fa-solid fa-xl #{value ? 'fa-check-circle text-success' : 'fa-times-circle text-danger'}")
    end
  end

  def boolean_container(value, text)
    content_tag(:div, class: "container-fluid rounded border my-2 p-1 text-center #{value ? 'border-success text-success' : 'border-danger text-danger'}") do
      text
    end
  end
  
  def status_badge_decision_doi(value)
    if value == "fait_de_course"
      content_tag(:span, "fait de course", class: "badge bg-success")
    else
      content_tag(:span, "responsable", class: "badge bg-danger")
    end
  end



  def badge_score_position(value)
    content_tag(:div, class: "badge-pos max-record-height rounded d-flex align-items-center justify-content-center mx-1") do 
      [value].join.html_safe
    end
  end

  def badge_points_licence(value, nature)
    text_class =
      case nature
      when "perte"
        "text-danger"
      when "gain"
        "text-success"
      when "solde"
        "text-light"
      else
        ""  # Default class or no class if nature doesn't match any condition
      end
  
    content_tag(:div, class: "badge-pos max-record-height rounded d-flex align-items-center justify-content-center ms-1 #{text_class}") do 
      value
    end
  end
  

end
  