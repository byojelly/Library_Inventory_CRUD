class CreateBooksharemembers < ActiveRecord::Migration[5.1]
  def change
    create_table :booksharemembers do |l|
          l.integer :consumer_id
          l.integer :library_id
    end
  end
end
