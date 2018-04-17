class User < ApplicationRecord
  has_many :goals
  has_many :results, through: :goals
  has_many :reflections, through: :results

  validates :name, :email, presence: true
  validates :email, uniqueness: true

  has_secure_password

  def average_success_rate
    success_rates = self.goals.collect do |goal|
      goal.success_rate
    end
    success_rates.inject(:+) / success_rates.size
  end
end
