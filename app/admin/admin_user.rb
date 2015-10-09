ActiveAdmin.register AdminUser do
  permit_params :email, :password, :password_confirmation, :role, :full_name, :employee_id

  index do
    selectable_column
    id_column
    column :email
    column :current_sign_in_at
    column :sign_in_count
    column :created_at
    actions
  end

  filter :email
  filter :current_sign_in_at
  filter :sign_in_count
  filter :created_at

  form do |f|
    f.inputs "Admin Details" do
      f.input :employee_id
      f.input :full_name
      f.input :email
      f.input :role, :as => :radio, collection: AdminUser.roles
      f.input :password
      f.input :password_confirmation
    end
    f.actions
  end

end
