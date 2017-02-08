class Request
  include DataMapper::Resource

  property :id, Serial
  property :date_requested, DateTime
  property :created_at, DateTime
  property :status, String

  belongs_to :user
  belongs_to :space

  # def owner
  #   space.user
  # end
  #
  # def requester
  #   user
  # end

end
