class Comment < ActiveRecord::Base
	belongs_to :user, :through => :post
	belongs_to :post
end
