class Consumer < ActiveRecord::Base
  has_secure_password #sets up bcrypt password

  belongs_to :library

  has_many :booksharemembers
  has_many :libraries, through: :booksharemembers


end
