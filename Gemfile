source 'http://rubygems.org'
# ruby '2.2.1'
# ruby '2.3.0'

gem 'pry'

gem 'sinatra-activerecord'
# the adapter between Sinatra and
# the ActiveRecord library
gem 'sinatra-reloader'
#This automatically reloads so you dont have to keep exiting 

gem 'rake'
# a command line task runner 

gem 'rack-flash3'
# leaves something on page but allows if refresh leaves -- flash method


##ask gemfile to differentiate depending on the mode -> development or production
group :development do 
	gem 'sqlite3'
end 

group :production do 
	gem "pg"
end 


