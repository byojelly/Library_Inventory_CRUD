class Section < ActiveRecord::Base
  belongs_to :library
  has_many :books


    validates :name, :location, :library_id, presence: true # { message: 'Please do not leave the input sections empty when submiting an edit.' }
    validates :name, length: { maximum: 30 }
    validates :location, length: { maximum: 100 }
    validates :name, uniqueness: { case_sensitive: false }


#testing validations
#make sure exists/filled in
#  validates :name, presence: true
  #validates :location, presence: true
  #validates :library_id, presence: true

#used for associations (has many) but should only be done on 1 side not both

  #validates_associated :books

#uniqueness
#  validates :name, uniqueness: { case_sensitive: false }

#acceptance method for things like terms of service  you can define a message
# =>   validates :terms_of_service, acceptance: { message: 'must be abided' }

# =>    validates :legacy_code, format: { with: /\A[a-zA-Z]+\z/, message: "only allows letters" }

#length
#class Person < ApplicationRecord
#  validates :name, length: { minimum: 2 }
#  validates :bio, length: { maximum: 500 }
#  validates :password, length: { in: 6..20 }
#  validates :registration_number, length: { is: 6 }
#end

#numerical
#class Player < ApplicationRecord
#  validates :points, numericality: true
#  validates :games_played, numericality: { only_integer: true }
#end

#presence
#class Person < ApplicationRecord
#  validates :name, :login, :email, presence: true
#end

#  validations with if statements
#class Order < ApplicationRecord
#  validates :card_number, presence: true, if: :paid_with_card?
#
#  def paid_with_card?
#    payment_type == "card"
#  end
#end


#if with multiple attributes
#class User < ApplicationRecord
#  with_options if: :is_admin? do |admin|
#    admin.validates :password, length: { minimum: 10 }
#    admin.validates :email, presence: true
#  end
#end

# => views page
# =>            <% if @article.errors.any? %>
# =>              <div id="error_explanation">
# =>                <h2><%= pluralize(@article.errors.count, "error") %> prohibited this article from being saved:</h2>
# =>
# =>                <ul>
# =>                <% @article.errors.full_messages.each do |msg| %>
# =>                  <li><%= msg %></li>
# =>                <% end %>
# =>                </ul>
# =>              </div>
# =>            <% end %>

end
