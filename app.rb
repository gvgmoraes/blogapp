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

get '/user_id' do 
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
			redirect "/user_id"
		else
			flash[:alert] = "There was a problem signing you in."
			# puts params.inspect
			redirect '/'		
		end
end


post '/posts/create' do
	post = Post.create(params[:post])
	redirect "/posts/#{post.id}"
end 


get '/posts/new' do 
	erb :new_post

end 


 get '/posts/:id' do 
	@post = Post.find(params[:id])
	puts @post.user.user_name
	erb :show2

end 



# post '/posts/create' do
# 	@post = Post.create(params[:post])
# end 

