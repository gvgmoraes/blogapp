# IN TERMINAL: 
# bundle 
# rake db:create_migration NAME=create_users_table 
# rake db:migrate 


# irb 
# require './app'

# rake db:seed
# User.delete_all 
Post.delete_all


# users =User.create([
# 	{username:"bootstrapbill",password:"12345",email:"bootstrapbill@blogapp.com"},
# 	{username: "gio3000", password: "12345", email:"gio3000@blogapp.com"},
# 	{username: "ohadyoudoin", password: "12345", email:"ohadyoudoin@blogapp.com"}, 
# 	{username: "liandy", password: "12345", email:"leandy@blogapp.com"},
# 	{username: "keynoa", password: "12345", email:"keynoal@blogapp.com"}
# ])



@all=User.all ## all users

posts = Post.create([
	{user_id: @all.sample.id, body: "Howdy"},
	{user_id: @all.sample.id, body: "You're Ugly!!!"},
	{user_id: @all.sample.id, body: "SICKKKKK"},
	{user_id: @all.sample.id, body: "woke up like dis"},
	{user_id: @all.sample.id, body: "moneyCa$$$H"},
	{user_id: @all.sample.id, body: "Funk you up..."}
])


