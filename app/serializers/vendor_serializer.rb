class VendorSerializer
  include JSONAPI::Serializer
  attributes :name, :alias, :codetype_id
end
