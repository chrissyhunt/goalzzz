class ReflectionSerializer < ActiveModel::Serializer
  attributes :id, :content, :result_id
  belongs_to :result
end
