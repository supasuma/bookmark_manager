require 'sinatra/base'
require 'data_mapper'
require 'dm-postgres-adapter'

class BookMark < Sinatra::Base

  get '/' do
    'Hello'
  end

  get '/links' do
    @links = Link.all
    erb :'links/index'
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
