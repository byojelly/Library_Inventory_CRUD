class Librarian < ActiveRecord::Base
  has_secure_password #sets up bcrypt password

  belongs_to :library


end
