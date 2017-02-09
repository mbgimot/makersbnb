ENV['RACK_ENV'] ||= 'development'

require 'sinatra/base'
require_relative 'datamapper_setup'
require 'sinatra/flash'
require 'encrypted_cookie'
require_relative 'helpers'


class MakersBnB < Sinatra::Base

  register Sinatra::Flash
  use Rack::MethodOverride
  use Rack::Session::EncryptedCookie,
    secret: '1ad3e5c2b617e329aad83a5749d133ea426070d31bd2e11f9f4df626f966a259'
  helpers Helpers

  get '/' do
    @current_user = current_user
    @spaces = Space.all.reverse
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
      redirect '/spaces/view'
    else
      session[:email] = params[:email]
      session[:name] = params[:name]
      flash[:errors] = user.errors.full_messages
      redirect '/users/new'
    end
  end

  get '/sessions/new' do
    erb(:'sessions/new')
  end

  post '/users/existing' do
    user = User.authenticate(params[:email], params[:password])
    if user
      session[:user_id] = user.id
      redirect '/spaces/view'
    else
      flash[:errors] = ['The email or password is incorrect.']
      redirect '/sessions/new'
    end
  end

  delete '/sessions' do
    session[:user_id] = nil
    session[:email] = nil
    session[:name] = nil
    flash.keep[:notice] = "Goodbye!"
    redirect to '/'
  end

  get '/spaces/view' do
    @spaces = Space.all.reverse
    erb(:'spaces/view')
  end

  get '/spaces/new' do
    erb(:'spaces/new')
  end

  post '/spaces/new' do
    user = User.get(session[:user_id])
    space = user.spaces.create(name: params[:name], description: params[:description], price: params[:price], available_from: params[:available_from], available_to: params[:available_to])
    redirect '/spaces/view'
  end

  get '/spaces/:id' do
    @space = Space.first(id: params[:id])
    @to = @space.available_to.strftime("%d/%m/%Y")
    @from = @space.available_from.strftime("%d/%m/%Y")
    erb(:'spaces/space')
  end

  get '/requests/view' do
    @user = current_user
    erb(:'requests/view')
  end

  post '/requests/new' do
    @user = current_user
    space = Space.first(id: params[:id])
    booking_date = params[:date_requested]
    if @user.id == space.user_id
      flash.now[:cannot_book_own_space] = ["Cannot request to book own property"]
    else
      request = space.requests.create(date_requested: params[:date_requested], user: @user)
      flash.next[:request_sent] = ["Your request has been sent to the owner"]
      redirect '/requests/view'
    end
  end

  get '/requests/:id' do
    @user = current_user
    @booking = Request.first(id: params[:id])
    @space = Space.first(id: @booking.space_id)
    @rentee = User.first(id: @booking.user_id)
    @owner = User.first(id: @space.user_id)
    erb(:'requests/request')
  end

  put '/requests/ammend' do
    booking = Request.first(id: params[:id])
    if params[:confirm]
      booking.update(status: :confirmed)
    elsif params[:decline]
      booking.update(status: :declined)
    end
    redirect '/requests/view'
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
