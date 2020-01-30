class NewUser < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :authorname
      t.string :email
      t.string :phone
      t.string :userid
      t.text :contactAdd
      t.string :right
      t.string :login
      t.text   :password_digest
      t.timestamps
    end
  end
end
