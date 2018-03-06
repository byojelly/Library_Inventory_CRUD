class User < ActiveRecord::Base
  has_secure_password #sets up bcrypt password
                      #is an active record method, that provides authenticate

  belongs_to :library

  has_many :booksharemembers
  has_many :libraries, through: :booksharemembers

  def self.librarians
    where(librarian: true)
  end
end
