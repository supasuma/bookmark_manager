require 'sinatra/base'
require 'data_mapper'
require 'dm-postgres-adapter'

class BookMark < Sinatra::Base

  get '/links' do
    @links = Link.all
    erb :'links/index'
  end

  get '/links/new' do
    erb :'links/new'
  end

  post '/links' do
    Link.create(url: params[:url], title: params[:title])
    redirect '/links'
  end


  run! if app_file == $0
end
