class ResultatsController < ApplicationController
  before_action :set_resultat, only: %i[ show edit update destroy ]

  def index

    @ligueId = params[:ligueId]
    @saisonId = params[:saisonId]
    @divisionId = params[:divisionId]
    session[:divisionId] = @divisionId

    @eventId = params[:eventId]
    session[:eventId] = @eventId

    @ligues = Ligue.all

    # filtre saisons ligue courante
    if @ligueId.present?
      @ligue = Ligue.find(@ligueId) 
      @saisons = @ligue.saisons
    end

     # filtre divisions saison courante
    if @saisonId.present?
      @saison = Saison.find(@saisonId) 
      @divisions = @saison.divisions
    end

    # filtre events division courante
    if @divisionId.present?
      @division = Division.find(@divisionId) 
      @events = @division.events
    end

    # filtre resultats event courant
    if @eventId.present?
      @event = Event.find(@eventId) 
      @resultats = @event.resultats.order(:course)
    end

    @ligue = Ligue.find(@ligueId) if @ligueId.present?
    @saison = Saison.find(@saisonId) if @saisonId.present?
    @division = Division.find(@divisionId) if @divisionId.present?
    @event = Event.find(@eventId) if @eventId.present?

    @circuitId = Event.find(@eventId).circuit_id if @eventId.present?
    @circuit = Circuit.find(@circuitId) if @circuitId.present?

    # filtre pilotes division courante
    if session[:divisionId].present?
      @division = Division.find(session[:divisionId]) 
      @pilotes = @division.pilotes
    end
    
    @equipes = Equipe.all

    
  end

  def show
  end

  def new
    @resultat = Resultat.new(resultat_params)

    @event = Event.find(params[:eventId])
    @division = @event.division
    @pilotes = @division.pilotes
    
    @equipes = Equipe.all
  end

  def edit
    if session[:divisionId].present?
      @division = Division.find(session[:divisionId]) 
      @pilotes = @division.pilotes
    end

    @equipes = Equipe.all

    respond_to do |format|
      format.html
      format.turbo_stream do  
        render turbo_stream: turbo_stream.update(@resultat, partial: "resultats/form", 
          locals: {resultat: @resultat})
      end
    end
  end

  def create

    if session[:divisionId].present?
      @division = Division.find(session[:divisionId]) 
      @pilotes = @division.pilotes
    end

    @equipes = Equipe.all

    # filtre resultats event courant
    if session[:eventId].present?
      @event = Event.find(session[:eventId]) 
      @resultats = @event.resultats.order(:course)
    end

    @resultat = Resultat.new(resultat_params)

    respond_to do |format|
      if @resultat.save
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

    # filtre resultats event courant
    if session[:eventId].present?
      @event = Event.find(session[:eventId]) 
      @resultats = @event.resultats.order(:course)
    end

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

    if session[:eventId].present?
      @event = Event.find(session[:eventId]) 
      @resultats = @event.resultats
    end

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
