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
	current_user
	@recentPosts = Post.last(6)

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
	post = Post.create(params[:post])
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
	current_user
	erb :setting
end

get '/privacy' do 
	current_user
	erb :privacy
end




