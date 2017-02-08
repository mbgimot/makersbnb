class Request
  include DataMapper::Resource

  property :id, Serial
  property :date_requested, DateTime
  property :created_at, DateTime
  property :status, Enum[:pending, :declined, :confirmed], default: :pending

  belongs_to :user
  belongs_to :space
end
