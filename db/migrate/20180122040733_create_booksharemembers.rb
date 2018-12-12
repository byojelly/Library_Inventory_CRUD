class CreateBooksharemembers < ActiveRecord::Migration[5.1]
#this sets up our has_many through relationships
  def change
    create_table :booksharemembers do |l|
          l.integer :consumer_id
          l.integer :library_id
    end
  end
end
