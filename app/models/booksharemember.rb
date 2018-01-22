class Booksharemember < ActiveRecord::Base
  belongs_to :consumer
  belongs_to :library

end
