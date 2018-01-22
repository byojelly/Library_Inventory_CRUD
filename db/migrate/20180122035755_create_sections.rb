class CreateSections < ActiveRecord::Migration[5.1]
  def change
    create_table :sections do |l|
          l.string :name
          l.string :location
          l.integer :library_id
    end
  end
end
