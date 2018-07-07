class ResultSerializer < ActiveModel::Serializer
  attributes :id, :date, :status, :goal_id
end
