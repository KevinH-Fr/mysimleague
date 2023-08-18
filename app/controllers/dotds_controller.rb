class DotdsController < ApplicationController

  include DotdsHelper

  before_action :set_dotd, only: %i[ show edit update destroy ]
  before_action :user_connected_dotd_ouvert, only: %i[ new create edit update destroy ]
  before_action :user_first_vote, only: %i[ new create ]
  before_action :authorize_edit_user, only: %i[ edit update destroy ]

  def new
    @event = Event.find(params[:event]) 
    @dotd = Dotd.new
      
  end

  def edit

    @event = Event.find(@dotd.event_id)
    @division = Division.find(@event.division_id)

      respond_to do |format|
        format.html
        format.turbo_stream do  
          render turbo_stream: turbo_stream.update(@dotd, partial: "dotds/form", 
            locals: {dotd: @dotd})
        end
      end

  end

  def create
    @dotd = Dotd.new(dotd_params)
  #  @event = Event.find(@dotd.event_id)

        respond_to do |format|
          if @dotd.save
            flash.now[:success] = "dotd was successfully created"

            format.turbo_stream do
              render turbo_stream: [
                turbo_stream.update('new_dotd',
                  partial: "dotds/form",
                  locals: { dotd: Dotd.new }),
    
                turbo_stream.append('dotds',
                                     partial: "dotds/dotd",
                                     locals: { dotd: @dotd }),
    
                #maj de la partial new_dotd pour affichage conditionnel btn nouveau
                turbo_stream.update(:content_new_dotd, 
                  partial: 'dotds/new_dotd'),

                turbo_stream.update(
                  'partial-dotds-stats-container', partial: 'dotds/stats'
                  ),
                
                turbo_stream.prepend('flash',
                    partial: 'layouts/flash', locals: { flash: flash })
              ]
            end 

            format.html { redirect_to dotd_url(@dotd), notice: "dotd was successfully created." }
            format.json { render :show, status: :created, location: @dotd }
          else

            format.turbo_stream do
              render turbo_stream.update(
                'new_dotd',
                partial: "dotds/form",
                locals: { dotd: @dotd }
              )
            end

            format.html { render :new, status: :unprocessable_entity }
            format.json { render json: @dotd.errors, status: :unprocessable_entity }
          end
        end

  end

  def update

    @event = Event.find(session[:event])

      respond_to do |format|
        if @dotd.update(dotd_params)
          flash.now[:success] = "dotd was successfully updated"

          format.turbo_stream do
            render turbo_stream: [
              turbo_stream.update(@dotd, 
              partial: 'dotds/dotd', 
              locals: { dotd: @dotd }),

              turbo_stream.update(
                'partial-dotds-stats-container', partial: 'dotds/stats'
              ),
              turbo_stream.prepend('flash',
                partial: 'layouts/flash', locals: { flash: flash })

            ]
          end

          format.html { redirect_to dotd_url(@dotd), notice: "Dotd was successfully updated." }
          format.json { render :show, status: :ok, location: @dotd }
        else

          format.turbo_stream do
            render turbo_stream: turbo_stream.update(@dotd, 
              partial: 'dotds/form', 
              locals: { dotd: @dotd })
          end
        
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: @dotd.errors, status: :unprocessable_entity }
        end
      end

  end

  def destroy
    @dotd.destroy

    respond_to do |format|
      flash.now[:success] = "dotd was successfully destroyed"

      format.turbo_stream do
        render turbo_stream: [
          turbo_stream.remove(@dotd),
          
          turbo_stream.update(:content_new_dotd, 
            partial: 'dotds/new_dotd'
          ),

          turbo_stream.update(
           'partial-dotds-stats-container', partial: 'dotds/stats'
          ),

          turbo_stream.prepend('flash',
            partial: 'layouts/flash', locals: { flash: flash })

        ]
      end

      format.html { redirect_to dotds_url, notice: "Dotd was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    
    def user_connected_dotd_ouvert
      unless current_user && verif_delai_dotd(session[:event])
        redirect_to root_path, alert: "You are not authorized to perform this action."
      end
    end

    def user_first_vote
      if verif_presence_dotd(current_user.id, session[:event])
        redirect_to root_path, alert: "You are not authorized to perform this action."
      end
    end

    def authorize_edit_user
      unless current_user && verif_user_dotd(current_user, @dotd.user_id) 
        redirect_to root_path, alert: "You are not authorized to perform this action."
      end
    end

    def set_dotd
      @dotd = Dotd.find(params[:id])
    end

    def dotd_params
      params.require(:dotd).permit(:user_id, :association_user_id, :event_id)
    end
end
