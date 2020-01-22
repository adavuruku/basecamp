class CreateProjectThreads < ActiveRecord::Migration[6.0]
  def change
    create_table :project_threads do |t|
      t.text :description
      t.references :project, null: false, foreign_key: true
      t.timestamps
    end
    
  end
end
