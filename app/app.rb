require 'sinatra/base'
require_relative 'models/link'

class BookmarkManager < Sinatra::Base

  get '/' do
    "Hello Bookmark"
  end

  get '/links' do
    @links = Link.all
    erb :'links/index'
  end

  post '/links' do
    Link.create(url: params[:URL], title: params[:title])
    redirect '/links'
  end

  get '/links/new' do
    erb :'links/add_links'
  end

  run! if app_file == $0

end
