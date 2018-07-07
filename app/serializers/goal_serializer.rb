class GoalSerializer < ActiveModel::Serializer
  attributes :id, :description, :start_date, :end_date, :interval, :priority
end
