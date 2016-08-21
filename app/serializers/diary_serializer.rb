class DiarySerializer < ActiveModel::Serializer
  attributes :id, :title, :content, :user_id, :created_at
end
