class CreateProjectTasks < ActiveRecord::Migration[6.0]
  def change
    create_table :project_tasks do |t|
      t.text :description
      t.string :userid
      t.references :project, null: false, foreign_key: true
      t.timestamps
    end
  end
end
