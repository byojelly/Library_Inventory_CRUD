class DropConsumersLibrarians < ActiveRecord::Migration[5.1]
  def change
    drop_table :librarians
    drop_table :consumers
    end
end
