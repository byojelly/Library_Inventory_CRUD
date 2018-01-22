class Section < ActiveRecord::Base
  belongs_to :library
  has_many :books

end
