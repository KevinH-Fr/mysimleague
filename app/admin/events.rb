ActiveAdmin.register Event do

  permit_params do
    permitted = [:circuit_id, :division_id, :horaire, :numero, :typepari]
    permitted << :other if params[:action] == 'create' && current_user.admin?
    permitted
  end
  
end
