class UserStatustoUser < ActiveRecord::Migration
  def change
    add_column :users, :approve_status, :integer, default: 0
  end
end
