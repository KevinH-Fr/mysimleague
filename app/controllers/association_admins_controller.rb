class AssociationAdminsController < ApplicationController
  include AssociationAdminsHelper

  before_action :set_association_admin, only: %i[ show edit update destroy ]
  before_action :authorize_admin_ligue, only: %i[ new create show index edit update destroy ]

  def index
    @association_admins = AssociationAdmin.all
  end

  def show
  end

  def new
    @association_admin = AssociationAdmin.new
    @ligue = Ligue.find(params[:ligue]) if params[:ligue]

  end

  def edit
    @ligue = Ligue.find(@association_admin.ligue_id)

    respond_to do |format|
      format.turbo_stream do  
        render turbo_stream: turbo_stream.update(@association_admin, 
          partial: "association_admins/form", 
          locals: {association_admin: @association_admin})
      end
    end
  end

  def create
    @association_admin = AssociationAdmin.new(association_admin_params)

    respond_to do |format|
      if @association_admin.save

        
        format.turbo_stream do
          render turbo_stream: [
            turbo_stream.update('new_association_admin',
                               partial: "association_admins/form",
                               locals: { association_admin: AssociationAdmin.new }),
  
            turbo_stream.append('association_admins',
                                 partial: "association_admins/association_admin",
                                 locals: { association_admin: @association_admin })
          ]
        end

        format.html { redirect_to association_admin_url(@association_admin), notice: I18n.t('notices.successfully_created') }
        #format.html { redirect_back(fallback_location: url_for, notice: 'admin created.') }
        format.json { render :show, status: :created, location: @association_admin }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @association_admin.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @ligue = @association_admin.ligue
    respond_to do |format|
      if @association_admin.update(association_admin_params)

        format.turbo_stream do
          render turbo_stream: turbo_stream.update(@association_admin, 
                    partial: 'association_admins/association_admin', 
                    locals: { association_admin: @association_admin })
        end

        format.html { redirect_to association_admin_url(@association_admin), notice: I18n.t('notices.successfully_updated') }
        format.json { render :show, status: :ok, location: @association_admin }
      else

        format.turbo_stream do
          render turbo_stream: turbo_stream.update(@association_admin, 
                    partial: 'association_admins/form', 
                    locals: { association_admin: @association_admin })
        end

        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @association_admin.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @association_admin.destroy

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.remove(@association_admin)
      end
      format.html { redirect_to association_admins_url, notice: I18n.t('notices.successfully_destroyed') }
      format.json { head :no_content }
    end
  end

  private

    def authorize_admin_ligue
      unless current_user && verif_admin_ligue(current_user, session[:ligue]) 
        redirect_to root_path, alert: I18n.t('notices.unauthorized_action') 
      end
    end
    
    def set_association_admin
      @association_admin = AssociationAdmin.find(params[:id])
    end

    def association_admin_params
      params.require(:association_admin).permit(:user_id, :ligue_id, :admin, :valide, :actif)
    end
end
