class RattachementsController < InheritedResources::Base

  include AssociationAdminsHelper

  before_action :set_rattachement, only: %i[ show edit update destroy ]
  before_action :authorize_admin_ligue, only: %i[ index edit update destroy ]

  def create

    @rattachement = Rattachement.new(rattachement_params)

    respond_to do |format|
      if @rattachement.save
        flash.now[:success] = "demande rattachement was successfully created"

        format.turbo_stream do
          render turbo_stream: [

            turbo_stream.remove("home-rattachement"),

            turbo_stream.update('new_rattachement',
                                partial: "rattachements/form",
                                locals: { rattachement: Rattachement.new }),
  
            turbo_stream.append('rattachements',
                                 partial: "rattachements/rattachement",
                                 locals: { rattachement: @rattachement }),
            
            turbo_stream.prepend('flash', partial: 'layouts/flash', locals: { flash: flash })
          ]
        end

        format.html { redirect_to rattachement_url(@rattachement), notice: "rattachement was successfully created." }
        format.json { render :show, status: :created, location: @rattachement }
      else

        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @rattachement.errors, status: :unprocessable_entity }
      end
    end
  end


  def edit

    respond_to do |format|
      format.turbo_stream do  
        render turbo_stream: turbo_stream.update(@rattachement, 
          partial: "rattachements/form", 
          locals: {rattachement: @rattachement})
      end
    end
  end

  def update

      respond_to do |format|
        if @rattachement.update(rattachement_params)
          flash.now[:success] = "rattachement was successfully updated"

          format.turbo_stream do
            render turbo_stream: [
              turbo_stream.update(@rattachement, 
              partial: 'rattachements/rattachement', 
              locals: { rattachement: @rattachement }),

              turbo_stream.prepend('flash',
                partial: 'layouts/flash', locals: { flash: flash })

            ]
          end

          format.html { redirect_to rattachement_url(@rattachement), notice: "rattachement was successfully updated." }
          format.json { render :show, status: :ok, location: @rattachement }
        else

          format.turbo_stream do
            render turbo_stream: turbo_stream.update(@rattachement, 
              partial: 'rattachements/form', 
              locals: { rattachement: @rattachement })
          end
        
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: @rattachement.errors, status: :unprocessable_entity }
        end
      end

  end

  def destroy
    @rattachement.destroy

    respond_to do |format|
      flash.now[:success] = "rattachement was successfully destroyed"

      format.turbo_stream do
        render turbo_stream: [
          turbo_stream.remove(@rattachement),
          
          turbo_stream.update(:content_new_rattachement, 
            partial: 'rattachements/new_rattachement'
          ),

          turbo_stream.prepend('flash',
            partial: 'layouts/flash', locals: { flash: flash })

        ]
      end

      format.html { redirect_to rattachements_url, notice: "rattachement was successfully destroyed." }
      format.json { head :no_content }
    end
  end


  private

    def authorize_admin_ligue
      unless current_user && verif_admin_ligue(current_user, session[:ligue]) 
        redirect_to root_path, alert: I18n.t('notices.unauthorized_action') 
      end
    end
    
    def set_rattachement
      @rattachement = Rattachement.find(params[:id])
    end
    
    def rattachement_params
      params.require(:rattachement).permit(:user_id, :ligue_id, :message, 
        association_user_attributes: [:ligue_id, :user_id, :division_id, :equipe_id, :valide, :actif])
    end

end
