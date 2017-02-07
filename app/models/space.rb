
class Space
  include DataMapper::Resource

  property :id, Serial
  property :name, Text, :required => true
  property :description, Text, :length => 500, :required => true
  property :price, BigDecimal, precision: 15, scale: 2, :required => true
  property :availability, Boolean, :default => true
  belongs_to :user

end
