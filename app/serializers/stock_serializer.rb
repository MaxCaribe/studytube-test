class StockSerializer
  include JSONAPI::Serializer

  attributes :name
  belongs_to :bearer
end
