class CreateProjectAttacheds < ActiveRecord::Migration[6.0]
  def change
    create_table :project_attacheds do |t|
      t.text :comment
      t.string :userid
      t.references :project, null: false, foreign_key: true
      t.timestamps
    end
  end
end
