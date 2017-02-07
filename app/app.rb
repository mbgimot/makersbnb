ENV['RACK_ENV'] ||= 'development'

require 'sinatra/base'
require_relative 'datamapper_setup'
require 'sinatra/flash'
require 'encrypted_cookie'
require_relative 'helpers'


class MakersBnB < Sinatra::Base
  set :public_folder, Proc.new { File.join(root, 'static') }
  register Sinatra::Flash
  use Rack::MethodOverride
  use Rack::Session::EncryptedCookie,
    secret: '1ad3e5c2b617e329aad83a5749d133ea426070d31bd2e11f9f4df626f966a259'

  helpers Helpers

  before do
    Space.count > 0 ? @spaces = Space.all : @spaces = nil
  end

  get '/' do
    erb(:index)
  end

  get '/users/new' do
    session[:email] ? @email_res = session[:email] : nil
    session[:name] ? @name_res = session[:name] : nil
    erb(:'users/new')
  end

  post '/users/new' do
    user = User.create(name: params[:name], email: params[:email], password: params[:password], password_conf: params[:password_conf])
    if user.save
      session[:user_id] = user.id
      redirect '/spaces'
    else
      session[:email] = params[:email]
      session[:name] = params[:name]
      flash[:errors] = user.errors.full_messages
      redirect '/users/new'
    end
  end

  post '/users/existing' do
    user = User.authenticate(params[:email], params[:password])
    if user
      session[:user_id] = user.id
      redirect '/spaces'
    else
      flash[:errors] = ['The email or password is incorrect.']
      redirect '/'
    end
  end

  delete '/sessions' do
    session[:user_id] = nil
    session[:email] = nil
    session[:name] = nil
    flash.keep[:notice] = "Goodbye!"
    redirect to '/'
  end

  get '/spaces' do

    erb(:'spaces/view')
  end

  get '/spaces/view' do
    erb :'spaces/view'
  end

  get '/spaces/new' do
    erb :'spaces/new'
  end

  post '/spaces/new' do
    space = @current_user.spaces.create(name: params[:name], description: params[:description], price: params[:price], availability: params[:availability], date_available: params[:date_available])
    redirect '/spaces/view'
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end