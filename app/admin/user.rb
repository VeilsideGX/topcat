ActiveAdmin.register User do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # permit_params :list, :of, :attributes, :on, :model
  #
  # or
  #
  permit_params do
    permitted = [:user, :email,:password]
  end
  
   before_filter :only => [:show, :edit, :update, :destroy] do
    @user = User.friendly.find(params[:id])
  end
  
  index do
    selectable_column
    column :id
    column :email
    column :approve_status
    actions do |user|
      link_to 'Approve', approve_admin_user_path(user) if user.pending?
    end
  end
  
  show do |user|
    attributes_table do
      row :id
      row :email
      row :created_at
    end
  end

  form do |f|
    f.inputs "User" do
      f.input :email
      f.input :password
    end
    f.actions
  end

  batch_action :approve do |selection|
    User.approve_user(params[:collection_selection])
    redirect_to admin_users_path, notice: 'Users has been approved'
  end

  member_action :approve do
    User.approve_user([params[:id]])
    redirect_to admin_users_path, notice: 'User has been approved'
  end

end
