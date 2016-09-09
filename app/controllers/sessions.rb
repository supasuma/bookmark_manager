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
    User.send_token(params[:email])
    flash[:notice] = "You have been sent a recovery email"
  end

  get '/sessions/reset/:token' do
    @token = params[:token]
    erb :'sessions/reset'
  end

  post '/sessions/reset' do
    update = User.reset_password(params[:token], params[:new_password], params[:password_confirmation])
    if update == false
      flash.now[:errors] = ["Your Passwords do not match"]
      erb :'sessions/reset'
    elsif update == :wrong_token
      flash[:errors] = ["Wrong Password Reset Link"]
      redirect '/sessions/recover'
    else
      flash[:notice] = "Your password has been reset"
      redirect '/sessions/new'
    end
  end

end
