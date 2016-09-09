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

  get '/sessions/recover' do
    erb :'sessions/recover'
  end

  post '/sessions/recover' do
    user = User.first(:email => params[:email])
    user.update(:token => 'ResetToken')
    token = user.token
    flash[:notice] = "You have been sent a recovery email - #{token}"
  end

  get '/sessions/reset/:token' do
    @token = params[:token]
    erb :'sessions/reset'
  end

  post '/sessions/reset' do
    check = User.reset_password(params[:token], params[:password], params[:password_confirmation])
    if check
      flash[:notice] = "Your password has been reset"
      redirect '/sessions/new'
    else
      flash[:error] = "Your password has not been reset"
      redirect '/sessions/reset/ResetToken'
    end
  end

end
