class PurchasesController < InheritedResources::Base

  before_action :authorize_admin

  private

    def purchase_params
      params.require(:purchase).permit(:status, :article_id, :user_id, :stripe_ref)
    end

    def authorize_admin
      unless current_user && current_user.admin 
        redirect_to root_path, alert: "You are not authorized to perform this action."
      end
    end

end
