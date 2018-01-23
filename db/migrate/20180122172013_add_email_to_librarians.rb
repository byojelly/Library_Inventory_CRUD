class AddEmailToLibrarians < ActiveRecord::Migration[5.1]
  def change
      add_column :librarians, :email, :string
  end
end
