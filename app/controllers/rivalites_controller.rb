class RivalitesController < InheritedResources::Base

  include AssociationAdminsHelper

  before_action :set_rivalite, only: %i[ show edit update destroy ]
  before_action :authorize_admin_ligue, only: %i[ new create edit update destroy ]


  def create
    @rivalite = Rivalite.new(rivalite_params)
    @event = Event.find(session[:event])
  
    respond_to do |format|
      if @rivalite.save

        flash.now[:success] = "rivalité was successfully created"

        format.turbo_stream do
          render turbo_stream: [
            turbo_stream.update('new_rivalite',
              partial: "rivalites/form",
              locals: { rivalite: Rivalite.new }),

            turbo_stream.append('rivalites',
                                 partial: "rivalites/rivalite",
                                 locals: { rivalite: @rivalite }),
            
            turbo_stream.prepend('flash',
                                  partial: 'layouts/flash', locals: { flash: flash })
          ]
        end


        format.html { redirect_to rivalites_path, notice: "rivalite was successfully created." }
        format.json { render :show, status: :created, location: @rivalite }
      else

        format.turbo_stream do
          render turbo_stream: turbo_stream.update(@rivalite, 
                    partial: 'rivalites/form', 
                    locals: { rivalite: @rivalite })
        end

        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @rivalite.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit

    respond_to do |format|
      format.html
      format.turbo_stream do  
        render turbo_stream: turbo_stream.update(@rivalite, partial: "rivalites/form", 
          locals: {rivalite: @rivalite})
      end
    end

end

def update

  @event = Event.find(session[:event])

  respond_to do |format|
    if @rivalite.update(rivalite_params)

      format.turbo_stream do
        render turbo_stream: turbo_stream.update(@rivalite, partial: 'rivalites/rivalite', locals: { rivalite: @rivalite })
      end

      format.html { redirect_to rivalite_url(@rivalite), notice: "rivalite was successfully updated." }
      format.json { render :show, status: :ok, location: @rivalite }
    else

      format.turbo_stream do
        render turbo_stream: turbo_stream.update(@rivalite, partial: 'rivalites/form', locals: { rivalite: @rivalite })
      end

      format.html { render :edit, status: :unprocessable_entity }
      format.json { render json: @rivalite.errors, status: :unprocessable_entity }
    end
  end

end

def destroy
  @rivalite.destroy

  respond_to do |format|

    format.turbo_stream do
      render turbo_stream: [
        turbo_stream.remove(@rivalite),
        turbo_stream.prepend('flash',
            partial: 'layouts/flash', locals: { flash: flash })
      ]
    end

    format.html { redirect_to rivalites_url, notice: "rivalite was successfully destroyed." }
    format.json { head :no_content }
  end
end

def generate_image
  @event = Event.find(params[:event])
  @rivalites = Rivalite.where(statut: true, division: @event.division_id)
  render "rivalites/document"
end


  private

  def set_rivalite
    @rivalite = Rivalite.find(params[:id])
  end

  def authorize_admin_ligue
    unless current_user && verif_admin_ligue(current_user, session[:ligue]) 
      redirect_to root_path, alert: "You are not authorized to perform this action."
    end
  end



    def rivalite_params
      params.require(:rivalite).permit(:division_id, :pilote1_id, :pilote2_id, :statut)
    end

end
