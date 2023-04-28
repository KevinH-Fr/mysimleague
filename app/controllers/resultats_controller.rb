class ResultatsController < ApplicationController
  before_action :set_resultat, only: %i[ show edit update destroy ]

  def index


    # filtre pilotes division courante
  #  if session[:divisionId].present?
  #    @division = Division.find(session[:divisionId]) 
  #    @pilotes = @division.pilotes
  #  end
    
    @equipes = Equipe.all

    if params[:divisionId].present?
      @division = Division.find(params[:divisionId]) 
      @pilotes = @division.pilotes
    end

  end

  def show
  end

  def new
    @resultat = Resultat.new(resultat_params)

  end

  def edit
      @event = Event.find(@resultat.event_id)
      @division = Division.find(@event.division_id) 
      @pilotes = @division.pilotes


    @equipes = Equipe.all
   # @pilotes = Pilote.all

    respond_to do |format|
      format.html
      format.turbo_stream do  
        render turbo_stream: turbo_stream.update(@resultat, partial: "resultats/form", 
          locals: {resultat: @resultat})
      end
    end
  end

  def create

   # if session[:divisionId].present?
   #   @division = Division.find(session[:divisionId]) 
   #   @pilotes = @division.pilotes
   # end


    # filtre resultats event courant
   # if session[:eventId].present?
    #@event = Event.find(1) 
    #@resultats = @event.resultats.order(:course)
   # end

     @equipes = Equipe.all
     @pilotes = Pilote.all

    @resultat = Resultat.new(resultat_params)

    respond_to do |format|
      if @resultat.save

        @event = Event.find(@resultat.event_id) 
        @resultats = @event.resultats.order(:course)
       
        @equipes = Equipe.all
        @division = Division.find(@event.division_id) 
        @pilotes = @division.pilotes
    
        format.turbo_stream do
          flash.now[:notice] = "le resultat #{@resultat.id} a bien été ajouté"
          render turbo_stream: [
            turbo_stream.update('new_resultat', partial: "resultats/form", locals: {resultat: Resultat.new}),
            turbo_stream.prepend("resultats", partial: "resultats/resultat",
              locals: {resultat: @resultat }), 
            
            # maj pour ordre des resultats
            turbo_stream.update(
                'resultats', partial: 'resultats', locals: { resultats: @resultats }),

            turbo_stream.update("flash", partial: "layouts/flash"),
            turbo_stream.update("resultat_counter", @resultats.count)
            ]
        end
        format.html { redirect_to resultat_url(@resultat), notice: "resultat was successfully created." }
        format.json { render :show, status: :created, location: @resultat }

      else
        flash.now[:notice] = "erreur - le resultat n'a pas été ajouté"
        format.turbo_stream do
          render turbo_stream: [
             turbo_stream.update("flash", partial: "layouts/flashError"),
           ]
         end
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @resultat.errors, status: :unprocessable_entity }

      end
    end
  end

  def update

    @resultat = Resultat.find(params[:id])
    # filtre resultats event courant
 #   if session[:eventId].present?
      @event = Event.find(@resultat.event_id) 
      @resultats = @event.resultats.order(:course)
  #  end

 #  @resultats = filtreEventCourantResultats()

    respond_to do |format|
      if @resultat.update(resultat_params)
        format.turbo_stream do  
          flash.now[:notice] = "le resultat #{@resultat.id} a bien été modifié"
          render turbo_stream: [
            turbo_stream.update(@resultat, partial: "resultats/resultat", 
              locals: {resultat: @resultat}),
            # maj pour ordre des resultats
            turbo_stream.update(
              'resultats', partial: 'resultats', locals: { resultats: @resultats }),
          
              turbo_stream.update("flash", partial: "layouts/flash")
           ]
        end

        format.html { redirect_to resultat_url(@resultat), notice: "resultat was successfully updated." }
        format.json { render :show, status: :ok, location: @resultat }
      else
        format.turbo_stream do  
          render turbo_stream: turbo_stream.update(@resultat, partial: "resultats/form", 
            locals: {resultat: @resultat})
        end
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @resultat.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy

    @resultat.destroy

  #  if session[:eventId].present?
      @event = Event.find(session[:eventId]) 
      @resultats = @event.resultats
  #  end

    respond_to do |format|
      
      format.turbo_stream do 
        render turbo_stream: [
          turbo_stream.remove(@resultat),
          turbo_stream.update("resultat_counter", @resultats.count)
        ]
      end
      
      format.html { redirect_to resultats_url, notice: "resultat was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_resultat
      @resultat = Resultat.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def resultat_params
      params.require(:resultat).permit(:event_id, :pilote_id, :equipe_id, :qualification, :course, :dotd, :mt, :score, :dnf, :dns)
    end
end
