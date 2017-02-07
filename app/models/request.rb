require 'dm-timestamps'

class Request
  include DataMapper::Resource

  property :id, Serial
  property :date_requested, DateTime
  property :created_at, DateTime
  property :status, :default => :pending
  # property :owner - NEED TO FIGURE OUT!

  belongs_to :user
  belongs_to :space

end
