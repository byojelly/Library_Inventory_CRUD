class CreateLibrarys < ActiveRecord::Migration[5.1]
  def change
    create_table :librarys do |l|
          l.string :name
          l.string :contact_phone
          l.string :contact_email
          l.string :address_street
          l.string :address_city
          l.string :address_state
          l.string :address_zipcode
          l.string :hours_of_operation
    end
  end
end
