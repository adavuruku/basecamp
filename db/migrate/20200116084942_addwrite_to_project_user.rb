class AddwriteToProjectUser < ActiveRecord::Migration[6.0]
  def change
    add_column :project_users, :wri, :boolean, :default=> false
    add_column :project_users, :rea, :boolean, :default=> true
    add_column :project_users, :del, :boolean, :default=> false
    add_column :project_users, :edi, :boolean, :default=> false
  end
end