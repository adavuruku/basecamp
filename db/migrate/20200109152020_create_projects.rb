class CreateProjects < ActiveRecord::Migration[6.0]
  def change
    create_table :projects do |t|
      t.string :projectid
      t.string :userid
      t.text :description
      t.text :title
      t.string :status
      t.timestamps
    end
  end
end
