class User < ApplicationRecord
  has_secure_password
  has_many :goals
  has_many :results, through: :goals
  has_many :reflections, through: :results
  validates :name, presence: true
  validates :email, uniqueness: true
end
