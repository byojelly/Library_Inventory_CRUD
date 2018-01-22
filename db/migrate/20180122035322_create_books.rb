class CreateBooks < ActiveRecord::Migration[5.1]
  def change
      create_table :books do |l|
            l.string :name
            l.string :author
            l.integer :pages
            l.string :available
            l.integer :library_id
            l.integer :section_id
      end
  end
end
