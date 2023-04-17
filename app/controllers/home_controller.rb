class HomeController < ApplicationController
 
  def index
    feed_pilotes = Pilote.order(updated_at: :desc).limit(5)
    feed_ligues =  Ligue.order(updated_at: :desc).limit(5)
    feed_saisons =  Saison.order(updated_at: :desc).limit(5)
    feed_divisions =  Division.order(updated_at: :desc).limit(5)

    feed_circuits =  Circuit.order(updated_at: :desc).limit(5)
    feed_ecuries =  Equipe.order(updated_at: :desc).limit(5)
    feed_events =  Event.order(updated_at: :desc).limit(5)
    feed_resultats =  Resultat.order(updated_at: :desc).limit(5)

    @feeds = []
    @feeds.concat(feed_pilotes)
    @feeds.concat(feed_ligues)
    @feeds.concat(feed_saisons)
    @feeds.concat(feed_divisions)

    @feeds.concat(feed_circuits)
    @feeds.concat(feed_ecuries)
    @feeds.concat(feed_events)
    @feeds.concat(feed_resultats)

    @feeds.sort_by!(&:updated_at).reverse!



    #tests models chainés
    # ligue division :
   # @ligue = Ligue.find(5)
   # @saisons = @ligue.saisons
   # @divisions = @ligue.divisions
  end

end