class CreateThreadMessages < ActiveRecord::Migration[6.0]
  def change
    create_table :thread_messages do |t|
      t.text :message
      t.string :userid
      t.references :project_thread, null: false, foreign_key: true
      t.timestamps
    end
  end
end
