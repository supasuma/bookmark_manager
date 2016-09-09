class BookMark < Sinatra::Base

  get '/links' do
    @links = Link.all
    erb :'links/index'
  end

  get '/links/new' do
    erb :'links/new'
  end

  post '/links' do
   link = Link.new(url: params[:url], title: params[:title])
   tags = params[:tags].split(' ')
   tags.each do |tag|
      single_tag = Tag.first_or_create(name: tag)
      link.tags << single_tag
    end
   link.save
   redirect '/links'
  end

  get '/tags/:name' do
    tag = Tag.first(name: params[:name])
    @links = tag ? tag.links : []
    erb :'links/index'
  end

end
