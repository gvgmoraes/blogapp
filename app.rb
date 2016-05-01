require 'sinatra'
require 'sinatra/activerecord'
require 'bundler/setup'
require 'rack-flash'
enable :sessions
use Rack::Flash, :sweep => true
# require 'sinatra/sinatra-reloader'
require './models'

configure(:development){set :database, 'sqlite3:blogapp.sqlite3'}
set :sessions, true 

def current_user
	if session[:user_id]
	@current_user = User.find(session[:user_id])
	# puts @current_user
	end
end

get '/' do
	erb :home
	#line that you can put so that it doesnt load layout
end


get '/user_home' do
	@user = current_user
	@posts = Post.last(20)


	@follower = Follow.where(following_id: current_user.id)
	@following = Follow.where(follower_id: current_user.id)
	# how do we change this to make it automatize w the user_id NUM not string 
	erb :userhome
end 



post '/sign_in' do
	@user = User.where(username: params[:username]).first
		# puts params.inspect
		if @user && @user.password == params[:password]
			# puts params.inspect
			session[:user_id] = @user.id
			flash[:notice] = "You've been signed in successfully."
			# redirect '/user_id'
			redirect "/user_home"
		else
			flash[:alert] = "There was a problem signing you in."
			# puts params.inspect
			redirect '/'		
		end
end


post '/post/create' do
	@user = current_user
	@post = Post.create(body: params[:body], user_id: params[:user_id])
	# redirect "/posts/#{post.id}"
	redirect "/recent" 
end 

# if you want the last 10 posts then @posts = current_user.posts.last(10)
get '/recent' do 
 	@posts = current_user.posts
	erb :new_post 

end 

get '/signout' do
	session.clear
	redirect "/"
end 

get '/set' do 
	erb :setting
end

get '/delete' do 
	@user = current_user
	@user.destroy
	session.clear
	redirect '/'
end 

post '/set' do
	current_user.update(username: params[:up_username], email: params[:up_email])
	flash[:notice] = "Account information update successful."
	redirect "/set" 
end 

# post '/like' do 
# 	@like = Like.create(user_id: params[:user_id], post_id: params[:post_id])
#     redirect back
# end

post '/like' do 
    @like = Like.create(user_id: params[:user_id], post_id: params[:post_id])
    puts "XXXXXXXXX #{@un_l}XXXXXXXXX"
   redirect '/user_home'
end

post '/unlike' do 
    @un_like = Like.where(user_id: params[:user_id], post_id: params[:post_id]).first
    puts "XXXXXXXXX #{@un_l}XXXXXXXXX"
    @un_like.destroy
   redirect '/user_home'
end

get '/privacy' do 
	current_user
	erb :privacy
end


get '/sign_up' do 
	erb :signup
end 

post '/sign_up' do 
	@user= User.create(username: params[:n_username], password: params[:n_password], email: params[:n_email])
	session[:user_id] = @user.id
	flash[:notice] = "Account Created!"
	redirect '/user_home'
end



