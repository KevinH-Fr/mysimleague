# Set the host name for URL creation
SitemapGenerator::Sitemap.default_host = "https://www.racemeifyoucan.com"

SitemapGenerator::Sitemap.create do
  # Put links creation logic here.
  #
  # The root path '/' and sitemap index file are added automatically for you.
  # Links are added to the Sitemap in the order they are specified.
  #
  # Usage: add(path, options={})
  #        (default options are used if you don't specify)
  #
  # Defaults: :priority => 0.5, :changefreq => 'weekly',
  #           :lastmod => Time.now, :host => default_host
  #
  # Examples:
  #
  # Add '/articles'
  #
  #   add articles_path, :priority => 0.7, :changefreq => 'daily'
  #
  # Add all articles:
  #
  #   Article.find_each do |article|
  #     add article_path(article), :lastmod => article.updated_at
  #   end

  add '/home', :changefreq => 'daily', :priority => 0.9
  add '/menu', :changefreq => 'daily', :priority => 0.9

  # Add sign-in and sign-up URLs to the sitemap
  add '/users/sign_in', :changefreq => 'daily', :priority => 0.8, :lastmod => Time.now
  add '/users/sign_up', :changefreq => 'daily', :priority => 0.8, :lastmod => Time.now

  Circuit.find_each do |circuit|
    add(circuit_path(circuit),
      :lastmod => circuit.updated_at,
      :changefreq => 'weekly',
      :priority => 0.7
    )
  end

  Ligue.find_each do |ligue|
    add(ligue_path(ligue),
      :lastmod => ligue.updated_at,
      :changefreq => 'weekly',
      :priority => 0.9
    )
  end

  User.find_each do |user|
    add(user_path(user),
      :lastmod => user.updated_at,
      :changefreq => 'weekly',
      :priority => 0.9
    )
  end

end
