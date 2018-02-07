class UsersChangeLibrarianBooleanDefaultValue < ActiveRecord::Migration[5.1]
  def change
    change_column :users, :librarian, :boolean, default: true
  end
end
