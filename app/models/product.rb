class Product < ActiveRecord::Base
	has_many :orders
	has_many :comments
	
	validates :name, presence: true


	def average_rating
		comments.average(:rating).to_f
	end


	 def comments_count
    $redis.scard(self.redis_key(:comments))
  end
  
end