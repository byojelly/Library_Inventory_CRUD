class CreateConsumers < ActiveRecord::Migration[5.1]
  def change
    create_table :consumers do |l|
          l.string :name
          l.string :username
          l.string :password_digest
          l.integer :age
          l.string :address
          l.string :email
          l.integer :library_id
    end
  end
end
