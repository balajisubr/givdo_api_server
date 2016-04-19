class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :image, :cover, :email, :total_score

  has_one :organization

  link(:self) { api_v1_user_url(object) }
end