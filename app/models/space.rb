class Space
  include DataMapper::Resource

  property :id, Serial
  property :name, Text, required: true
  property :description, Text, length: 500, required: true
  property :price, Float, precision: 5, scale: 2, required: true
  property :availability, Boolean, default: true
  property :date_available, Date
  property :image, Text

  belongs_to :user
  has n, :requests

end
