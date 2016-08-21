#
class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :diaries
end
