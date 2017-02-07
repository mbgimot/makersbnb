class Space
  include DataMapper::Resource

  property :id, Serial
  property :name, Text, :required => true
  property :description, Text, :length => 500, :required => true
  property :price, Decimal, :required => true
  property :availability, Boolean, :default => true
  property :date_available, DateTime

  belongs_to :user

end
