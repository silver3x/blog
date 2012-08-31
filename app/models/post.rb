class Post < ActiveRecord::Base
	self.primary_key = :post_id
	belongs_to :user
	has_many :comment, :dependent => :destroy
	validates_presence_of :content, :message => 'Post is blank !'
	validates_length_of :content, :maximum => 250, :message => 'Max.length 250 character !'
end
