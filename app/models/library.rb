class Library < ActiveRecord::Base
  has_many :books
  has_many :sections
  has_many :librarians
  has_many :booksharemembers
  has_many :consumers, through: :booksharemembers
end
