require 'sinatra'
require 'sinatra/activerecord'
require 'bundler/setup'
require 'rack-flash'
# enable :sessions
# use Rack::Flash, :sweep => true

# require 'sinatra/sinatra-reloader'
require './models'

set :database, 'sqlite3:blogapp.sqlite3'
# set :sessions, true 

# get '/' do
# 	@users = User.all
# 	erb :home
# 	#line that you can put so that it doesnt load layout
# end
