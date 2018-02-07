class Library < ActiveRecord::Base
  has_many :books
  has_many :sections
  #has many 2 has many through join table
  has_many :booksharemembers
  has_many :users, through: :booksharemembers
end
