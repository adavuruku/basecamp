class CreateProjectUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :project_users do |t|
      t.string :projectid
      t.string :userid
      t.timestamps
    end
  end
end