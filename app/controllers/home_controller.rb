class HomeController < ApplicationController
 
  def index
    feed_pilotes = Pilote.order(updated_at: :desc).limit(2)
    feed_ligues =  Ligue.order(updated_at: :desc).limit(2)

    @feeds = []
    @feeds.concat(feed_pilotes)
    @feeds.concat(feed_ligues)

    @feeds.sort_by!(&:updated_at).reverse!
  
  end

end