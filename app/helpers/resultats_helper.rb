module ResultatsHelper

  def dotd_mt_dnf_dns_indicators(dotd, mt, dnf, dns)
    content = []

    if dotd
      content << content_tag(:i, "", class: "fa fa-star fa-xl icon-indicator-resultat fw-bold pe-2")
    end

    if mt
      content << content_tag(:i, "", class: "fa fa-stopwatch-20 fa-xl icon-indicator-resultat fw-bold pe-2")
    end

    if dnf
      content << content_tag(:span, "DNF", class: "badge p-1 text-center rounded bg-light text-danger fw-bold me-2")
    end

    if dns
      content << content_tag(:span, "DNS", class: "badge p-1 text-center rounded bg-light text-danger fw-bold me-2")
    end

    content_span = content_tag(:span, content.join(" ").html_safe, 
      class: "text-light fw-bold d-flex align-items-center position-absolute top-50 translate-middle-y px-2")
    content_span
  end

  def equipe_banner_pilote_and_indicators(equipe, pilote, dotd, mt, dnf, dns)
    if equipe.banniere.present?
      equipe_banner_with_pilote(equipe, pilote) +
      dotd_mt_dnf_dns_indicators(dotd, mt, dnf, dns)
    end
  end

end
