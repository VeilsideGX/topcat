ActiveAdmin.register Client do

  permit_params do
    permitted = [:client, :company_name, :company_email, :official_website, :zip, :country_id, :user_id]
  end
  
  form do |f|
    f.inputs "Client" do
      f.input :user, :collection => User.not_assign_user.map{|u| [u.email, u.id]}
      f.input :company_name
      f.input :company_email
      f.input :official_website
      f.input :country_id, as: 'select', collection: Country.all,label: "Country"
      f.input :zip
    end
    f.actions
  end
  
  show do |band|
    attributes_table do
      row :id
      row :user_id
      row :company_name
      row :company_email
      row :official_website
      row :country_id
      row :zip
      row :created_at
    end
  end
  
  index do
    column :id
    column :user_id do |client|
      client.user.email
    end
    column :company_name
    column :company_email
    column :official_website
    column :country_id
    column :zip
    column :created_at
    actions
  end
end