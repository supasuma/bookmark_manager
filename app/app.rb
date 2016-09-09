require 'sinatra/base'
require 'sinatra/flash'
require 'sinatra/partial'
require_relative 'data_mapper_setup'
require_relative 'controllers/links'
require_relative 'controllers/sessions'
require_relative 'controllers/users'

class BookMark < Sinatra::Base

  register Sinatra::Partial
  set :partial_template_engine, :erb
  enable :partial_underscores

  enable :sessions
  set :views, File.dirname(__FILE__) + '/views'
  set :session_secret, 'super secret'

  register Sinatra::Flash


  get '/' do
    redirect '/links'
  end

  helpers do
    def current_user
      @current_user ||= User.get(session[:user_id])
    end
  end

  run! if app_file == $0
end
