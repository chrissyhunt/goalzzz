class Reflection < ApplicationRecord
  belongs_to :result
  belongs_to :user, through: :result
  validates :content, :result_id, presence: true
end
