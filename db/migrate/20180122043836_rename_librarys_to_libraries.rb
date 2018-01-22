class RenameLibrarysToLibraries < ActiveRecord::Migration[5.1]
  def change
    rename_table :librarys, :libraries
  end
end
