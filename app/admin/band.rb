ActiveAdmin.register Band do

  permit_params do
    permitted = [:band, :band_name, :music_genre, :zip, :country_id, :user_id]
  end
  
  form do |f|
    f.inputs "Band" do
      f.input :user, :collection => User.not_assign_user.map{|u| [u.email, u.id]}
      f.input :band_name
      f.input :music_genre
      f.input :country_id, as: 'select', collection: Country.all,label: "Country"
      f.input :zip
    end
    f.actions
  end
  
  show do |band|
    attributes_table do
      row :id
      row :band_name
      row :user_id
      row :music_genre
      row :country_id
      row :created_at
    end
  end
  
  index do
    column :id
    column :band_name
    column :user_id do |band|
      band.user.email
    end
    column :music_genre
    column :country_id
    column :created_at
    actions
  end
end