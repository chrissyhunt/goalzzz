class Reflection < ApplicationRecord
  belongs_to :result
  validates :content, presence: true
end
