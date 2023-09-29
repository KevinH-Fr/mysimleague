module ApplicationHelper
    include Pagy::Frontend
    
    def resource_name
        :user
    end

    def resource
        @resource ||= User.new
    end

    def resource_class
        User 
    end

    def devise_mapping
        @devise_mapping ||= Devise.mappings[:user] 
    end

    def icon_if_true(resultat)
        if resultat
            # Return the HTML for the success icon
            #'<i class="fa fa-check-circle text-success"></i>'.html_safe
          end
    end

    
    def valid_url?(url)
        uri = URI.parse(url)
        uri.is_a?(URI::HTTP) || uri.is_a?(URI::HTTPS)
    rescue URI::InvalidURIError
        false
    end


end
