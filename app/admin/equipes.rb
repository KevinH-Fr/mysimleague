ActiveAdmin.register Equipe do

  permit_params do
    permitted = [:nom, :couleurs]
    permitted << :other if params[:action] == 'create' && current_user.admin?
    permitted
  end
  
end
