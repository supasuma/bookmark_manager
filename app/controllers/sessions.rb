class BookMark < Sinatra::Base
  get '/sessions/new' do
    erb :'sessions/new'
  end

  post '/sessions' do
    user = User.authenticate(params[:email], params[:password])
    if user
      session[:user_id] = user.id
      redirect to('/links')
    else
      flash.now[:errors] = ['The email or password is incorrect']
      erb :'sessions/new'
    end
  end

  get '/sessions/sign_out' do
    flash[:notice] = "See ya later sucker, #{current_user.email}"
    session[:user_id] = nil
    redirect to('/links')
  end

end
