ActiveAdmin.register Artist do

  permit_params do
    permitted = [:artist, :full_name, :music_genre, :zip, :country_id, :user_id]
  end
  
  form do |f|
    f.inputs "Artist" do
      f.input :user, :collection => User.not_assign_user.map{|u| [u.email, u.id]}
      f.input :full_name
      f.input :music_genre
      f.input :country_id, as: 'select', collection: Country.all,label: "Country"
      f.input :zip
    end
    f.actions
  end
  
  show do |artist|
    attributes_table do
      row :id
      row :full_name
      row :user_id
      row :music_genre
      row :country_id
      row :created_at
    end
  end
  
  index do
    column :id
    column :full_name
    column :user_id do |artist|
      artist.user.email
    end
    column :music_genre
    column :country_id
    column :created_at
    actions
  end
end
