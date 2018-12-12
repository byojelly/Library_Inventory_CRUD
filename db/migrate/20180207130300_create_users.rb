class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |u|
          u.string :name
          u.string :username
          u.string :password_digest
                  #password_digest necessary for bcryp implementatioin
          u.integer :age
          u.integer :start_year
          u.integer :library_id
          u.string :email
          u.string :address
          u.string :email
          u.boolean :librarian


    end
  end
end
