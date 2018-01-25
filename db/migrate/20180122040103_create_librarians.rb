class CreateLibrarians < ActiveRecord::Migration[5.1]
  def change
    create_table :librarians do |l|
          l.string :name
          l.string :username
          l.string :password_digest
          l.integer :age
          l.integer :start_year
          l.integer :library_id
          l.string :email

    end
  end
end
