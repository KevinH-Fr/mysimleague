class LandingpageController < ApplicationController
  def index
    @nb_users = User.all.count
    @nb_courses = Event.where('horaire < ?', Time.now).count
    @nb_paris = Pari.all.count
  end

end
