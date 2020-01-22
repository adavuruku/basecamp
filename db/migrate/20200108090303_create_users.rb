class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :authorname
      t.string :email
      t.string :phone
      t.string :userid
      t.text :password
      t.text :contactAdd
      t.string :right
      t.string :login

      t.timestamps
    end

    
  end
end
