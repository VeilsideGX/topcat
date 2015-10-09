class AddRoleToAdminUser < ActiveRecord::Migration
  def change
    add_column :admin_users, :role, :integer, default: 0
    add_column :admin_users, :employee_id, :string
    add_column :admin_users, :full_name, :string
  end
end
