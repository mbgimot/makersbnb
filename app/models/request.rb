class Request
  include DataMapper::Resource

  property :id, Serial
  property :date_requested, Date
  property :created_at, DateTime
  property :status, String

  belongs_to :user
  belongs_to :space



end
