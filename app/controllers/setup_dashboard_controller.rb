class SetupDashboardController < ApplicationController
  def index
  end

  def display_correcteur

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.update(
          'partial-correcteur-container', partial: 'home/correcteur'
        )
      end
    end
  end
  
end
