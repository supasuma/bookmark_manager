require 'sinatra/base'

class book-mark < Sinatra::Base
  get '/' do
    'Hello book-mark!'
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
