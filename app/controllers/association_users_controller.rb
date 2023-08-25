class AssociationUsersController < ApplicationController

  include AssociationAdminsHelper

  before_action :set_association_user, only: %i[ show edit update destroy ]
  before_action :authorize_admin_ligue, only: %i[ new show index create edit update destroy ]
  

  def index
    @association_users = AssociationUser.all
  end

  def show
    @association_user = AssociationUser.find(params[:id])

    respond_to do |format|
      format.html # This will render the default HTML view for the show action (show.html.erb)
      format.json { render json: { equipe_id: @association_user.equipe_id } } # This will respond with JSON data
    end
  end

  def new
    @association_user = AssociationUser.new
    @division = Division.find(params[:division]) if params[:division]

    @pilotes = User.all

  end

  def edit
    respond_to do |format|
      format.turbo_stream do  
        render turbo_stream: turbo_stream.update(@association_user, 
          partial: "association_users/form", 
          locals: {association_user: @association_user})
      end
    end
  end

  def create

    @division = Division.find(session[:division])

    @association_user = AssociationUser.new(association_user_params)

    respond_to do |format|
      if @association_user.save

        format.turbo_stream do
          render turbo_stream: [
            turbo_stream.update('new_association_user',
                               partial: "association_users/form",
                               locals: { association_user: AssociationUser.new }),
  
            turbo_stream.append('association_users',
                                 partial: "association_users/association_user",
                                 locals: { association_user: @association_user }),

            turbo_stream.update(
            'partial-pilotes-division-stats-container', partial: 'divisions/new_pilote_division'
            ),
          ]
        end

        format.html { redirect_to association_user_url(@association_user), notice: "asso user was successfully created." }
        format.json { render :show, status: :created, location: @association_user }
      else

        format.turbo_stream do
          render turbo_stream.update(
            'new_association_user',
            partial: "association_users/form",
            locals: { association_user: @association_user }
          )
        end

        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @association_user.errors, status: :unprocessable_entity }
      end
    end
  end
  

  def update

    @division = @association_user.division

    respond_to do |format|
      if @association_user.update(association_user_params)

        format.turbo_stream do
          render turbo_stream: [
            turbo_stream.update(@association_user, 
                    partial: 'association_users/association_user', 
                    locals: { association_user: @association_user }),
            turbo_stream.remove('new_association_user'),


            turbo_stream.update(
              'partial-pilotes-division-stats-container', partial: 'divisions/new_pilote_division'
             )
   
          ]
        end

        format.html { redirect_to association_user_url(@association_user), notice: "Association was successfully updated." }
        format.json { render :show, status: :ok, location: @association_user }
      else

        format.turbo_stream do
          render turbo_stream: turbo_stream.update(@association_user, 
                    partial: 'association_users/form', 
                    locals: { association_user: @association_user })
        end

        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @association_user.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy

    @division = Division.find(session[:division])

    @association_user.destroy

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: [
          turbo_stream.remove(@association_user),
          
          turbo_stream.update(
            'partial-pilotes-division-stats-container', partial: 'divisions/new_pilote_division'
           )
          ]
      end

      format.html { redirect_to association_users_url, notice: "Association was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

    def authorize_admin_ligue
      unless current_user && verif_admin_ligue(current_user, session[:ligue]) 
        redirect_to root_path, alert: "You are not authorized to perform this action."
      end
    end

    def set_association_user
      @association_user = AssociationUser.find(params[:id])
    end

    def association_user_params
      params.require(:association_user).permit(:user_id, :ligue_id, :division_id, :equipe_id, :pilote, :admin, :valide, :actif)
    end
end
