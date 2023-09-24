class ResultatsController < ApplicationController
  include ParisHelper
  include AssociationUsersHelper
  include AssociationAdminsHelper

  before_action :set_resultat, only: %i[ show edit update destroy]
  before_action :authorize_admin_ligue, only: %i[ new show index create edit update destroy ]

  def new

    @event = Event.find(params[:event])
    @division = division_courante
    @pilotes = pilotes_division(@division)
    @resultat = Resultat.new
    @resultat.event_id = @event.id

    @equipes = Equipe.all
    
  end

  def edit
   
    @division = @resultat.event.division
    @pilotes = pilotes_division(@division)
    @equipes = Equipe.all

    respond_to do |format|
      format.html
      format.turbo_stream do  
        render turbo_stream: turbo_stream.update(@resultat, 
          partial: "resultats/form", 
          locals: {resultat: @resultat})
      end
    end

  end

  def create
    
    @resultat = Resultat.new(resultat_params)

    #@pilotes = AssociationUser.includes(:user).where(pilote: true)
    @equipes = Equipe.all
    @event = Event.find(session[:event]) 
    @resultats = @event.resultats.order(:course) 

    @division = Division.find(@event.division_id) if @event

    respond_to do |format|
      if @resultat.save
        flash.now[:success] = "resultat was successfully created"

        #call maj paris liés 
        update_paris_resultats(@resultat.event_id, @resultat.association_user_id, @resultat.qualification.to_i, @resultat.course.to_i,
        @resultat.dns)

        format.turbo_stream do
          render turbo_stream: [
            turbo_stream.update('new_resultat',
                                partial: "resultats/form",
                                locals: { resultat: Resultat.new }),
  
            turbo_stream.append('resultats',
                                partial: "resultats/resultat",
                                locals: { resultat: @resultat }),
            # Include a Turbo Stream command to display the flash notice
            turbo_stream.prepend('flash', partial: 'layouts/flash', locals: { flash: flash }),
            
            #ordering
            turbo_stream.update(
              'resultats', 
              partial: "menu/resultats",
              locals: { resultats: @resultats.order(:course) }
            )
          ]
        end

        format.html { redirect_to resultat_url(@resultat), notice: "resultat was successfully created." }
        format.json { render :show, status: :created, location: @resultat }
      else

        format.turbo_stream do
          render turbo_stream.update(
            'new_resultat',
            partial: "resultats/form",
            locals: { resultat: @resultat }
          )
        end

        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @resultat.errors, status: :unprocessable_entity }
      end
    end

  end

  def update

    @event = Event.find(@resultat.event_id)
    @resultats = @event.resultats.order(:course) 

    @division = Division.find(@event.division_id)
    @pilotes = AssociationUser.includes(:user).where(pilote: true)
    @equipes = Equipe.all

    respond_to do |format|
      if @resultat.update(resultat_params)
        flash.now[:success] = "resultat was successfully updated"

        #call maj paris liés 

        puts "____call update pari depuis resultat update"
        update_paris_resultats(
          @resultat.event_id, 
          @resultat.association_user_id, 
          @resultat.qualification.to_i, 
          @resultat.course.to_i,
          @resultat.dns
        )

        format.turbo_stream do
          render turbo_stream: [

            turbo_stream.update(@resultat,
              partial: 'resultats/resultat', 
              locals: { resultat: @resultat }),
            # Include a Turbo Stream command to display the flash notice


            turbo_stream.prepend('flash',
              partial: 'layouts/flash', locals: { flash: flash }),

            #ordering
            turbo_stream.update(
              'resultats', 
              partial: "resultats/resultats",
              locals: { resultats: @resultats.order(:course) }
            )
          ]
        end
        format.html { redirect_to resultat_url(@resultat), notice: "Resultat was successfully updated." }
        format.json { render :show, status: :ok, location: @resultat }
      else
        format.turbo_stream do
          render turbo_stream: turbo_stream.update(@resultat, partial: 'resultats/form', locals: { resultat: @resultat })
        end

        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @resultat.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @resultat.destroy

    respond_to do |format|
      flash.now[:success] = "resultat was successfully destroyed"

      #call maj paris liés 
      false_paris_resultats(@resultat.event_id, @resultat.association_user_id)


      format.turbo_stream do
        render turbo_stream: [
          turbo_stream.remove(@resultat),
        # Include a Turbo Stream command to display the flash notice
          turbo_stream.prepend('flash',
              partial: 'layouts/flash', locals: { flash: flash })
        ]
      end
      format.html { redirect_to resultats_url, notice: "Resultat was successfully destroyed." }
      format.json { head :no_content }

    end
  end

  def generate_image

    @event = Event.find(params[:event])
    @resultats = @event.resultats.order(:course) if @event.present?

    render "resultats/document"

  end

  def animation
    @event = Event.find(params[:event])
    @resultats = @event.resultats if @event.present?

    @resultats = @event.resultats.includes(:equipe, :association_user => :user).map do |resultat|
      {
        id: resultat.id,
        equipe_id: resultat.equipe_id,
        equipe_nom: resultat.equipe.nom,
        couleur: resultat.equipe.couleurs,
       # banniere: resultat.equipe.banniere, # Retrieve the logo attachment
       # banniere_url: resultat.equipe.banniere.url,
        equipe_color: resultat.equipe.couleurs,
        pilote: resultat.association_user.user.nom,
        qualification: resultat.qualification,
        course: resultat.course,
        score: resultat.score,
        dotd: resultat.dotd,
        mt: resultat.mt,
        delta_rank: resultat.qualification.to_i - resultat.course.to_i
      }
    end

  end

  private

    def authorize_admin_ligue
      unless current_user && verif_admin_ligue(current_user, session[:ligue]) 
        redirect_to root_path, alert: "You are not authorized to perform this action."
      end
    end

    def set_resultat
      @resultat = Resultat.find(params[:id])
    end

    def resultat_params
      params.require(:resultat).permit(:event_id, :association_user_id, :equipe_id, :qualification, :qualification_sprint, :course, :dotd, :mt, :score, :dnf, :dns)
    end
end