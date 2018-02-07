class BooksharemembersChangeConsumerIdToUserId < ActiveRecord::Migration[5.1]
  def change
    rename_column :booksharemembers, :consumer_id, :user_id
  end
end
