class User < ActiveRecord::Base
	has_many :posts
	has_many :likes, through: :posts 
	has_many :follows, through: :users
end 

class Post < ActiveRecord::Base
	belongs_to :user
	has_many :likes, through: :users
end 

class Like < ActiveRecord::Base
	belongs_to :post 
	#check if/select: 
	belongs_to :user
end 

class Follow < ActiveRecord::Base
	belongs_to :user
	# has_many :users, through: 
end 

