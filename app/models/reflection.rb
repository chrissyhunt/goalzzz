class Reflection < ApplicationRecord
  belongs_to :result
  belongs_to :user, through: :result
  validates :content, presence: true
end
