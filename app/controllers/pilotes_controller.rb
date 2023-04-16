class PilotesController < ApplicationController
  before_action :set_pilote, only: %i[ show edit update destroy ]

  def index

    @ligueId = params[:ligueId]
    @saisonId = params[:saisonId]
    @divisionId = params[:divisionId]

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

    # filtre pilotes division courante
    if @divisionId.present?
      @division = Division.find(@divisionId) 
      @pilotes = @division.pilotes
    end
  end

  def show
    @divisions = @pilote.divisions
  end
  

  def new
    @pilote = Pilote.new(pilote_params)


  end

  def edit
    respond_to do |format|
      format.html
      format.turbo_stream do  
        render turbo_stream: turbo_stream.update(@pilote, partial: "pilotes/form", 
          locals: {pilote: @pilote})
      end
    end
  end

  def create
    @pilote = Pilote.new(pilote_params)
    @divisionId = params[:divisionId]
   # puts "____division id depuis new: #{@divisionId}"

    respond_to do |format|
      if @pilote.save
        
       Participation.create(pilote_id: @pilote.id, division_id:   @divisionId)

        format.turbo_stream do
          flash.now[:notice] = "le pilote #{@pilote.nom} a bien été ajouté"
          render turbo_stream: [
            turbo_stream.update('new_pilote', partial: "pilotes/form", locals: {pilote: Pilote.new}),
            turbo_stream.prepend("pilotes", partial: "pilotes/pilote",
              locals: {pilote: @pilote }), 
              turbo_stream.update("flash", partial: "layouts/flash"),     
            ]
        end
       # format.html { redirect_to pilote_url(@pilote), notice: "Pilote was successfully created." }
       # format.json { render :show, status: :created, location: @pilote }

      else
        flash.now[:notice] = "erreur - le pilote n'a pas été ajouté"
        format.turbo_stream do
          render turbo_stream: [
             turbo_stream.update("flash", partial: "layouts/flashError"),
           ]
         end
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @pilote.errors, status: :unprocessable_entity }

      end
    end
  end

  def update
    @pilote = Pilote.find(params[:id])
#    @pilote.divisions << Division.find(params[:pilote][:division_ids])

    respond_to do |format|
      if @pilote.update(pilote_params)
        format.turbo_stream do  
          flash.now[:notice] = "le pilote #{@pilote.nom} a bien été modifié"
          render turbo_stream: [
            turbo_stream.update(@pilote, partial: "pilotes/pilote", 
              locals: {pilote: @pilote}),
              turbo_stream.update("flash", partial: "layouts/flash")
           ]
        end

        format.html  { redirect_to pilote_url(@pilote), notice: "Pilote was successfully updated." }
        format.json { render :show, status: :ok, location: @pilote }
      else
        format.turbo_stream do  
          render turbo_stream: turbo_stream.update(@pilote, partial: "pilotes/form", 
            locals: {pilote: @pilote})
        end
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @pilote.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @pilote.destroy

    respond_to do |format|
      format.turbo_stream { render turbo_stream: turbo_stream.remove(@pilote) }
      format.html { redirect_to pilotes_url, notice: "Pilote was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    def set_pilote
      @pilote = Pilote.find(params[:id])
    end

    def pilote_params
      params.fetch(:pilote, {}).permit(:nom)#, :divisionId, {division_ids: []})
    end
end
