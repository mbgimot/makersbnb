class Space
  include DataMapper::Resource

  property :id, Serial
  property :name, Text, required: true
  property :description, Text, length: 500, required: true
  property :price, Float, precision: 5, scale: 2, required: true
  property :available_from, Date, required: true
  property :available_to, Date, required: true

  belongs_to :user
  has n, :requests

  def confirmed_dates
    requests.map do |request|
      request.date_requested if request.status == :confirmed
    end
  end
end
