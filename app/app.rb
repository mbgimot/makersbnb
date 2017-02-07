ENV['RACK_ENV'] ||= 'development'

require 'sinatra/base'
require 'sinatra/flash'

require_relative 'datamapper_setup'


class MakersBnB < Sinatra::Base

  register Sinatra::Flash
  use Rack::MethodOverride

  DataMapper::Logger.new($stdout, :debug)


  get '/' do
    'Hello MakersBnB!'
  end

  get '/spaces/view' do
    erb :'spaces/view'
  end

  get '/spaces/list' do
    erb :'spaces/list'
  end

  post '/spaces/list' do
    redirect '/spaces/view'
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
