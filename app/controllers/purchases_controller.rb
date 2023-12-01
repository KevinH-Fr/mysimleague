class PurchasesController < InheritedResources::Base

  private

    def purchase_params
      params.require(:purchase).permit(:status, :article_id, :user_id, :stripe_ref)
    end

end
