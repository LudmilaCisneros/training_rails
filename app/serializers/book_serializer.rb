class BookSerializer < ActiveModel::Serializer
  attributes :id, :genre, :author, :image,
             :title, :publisher, :year
end
