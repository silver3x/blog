class HomeController < ApplicationController
  def index
  	@page  = "home"
  	@all_post = Post.all(:order => "created_at DESC")
  	@all_post.collect do |p| 
  		p.comment.collect do |c|
  			@user_by_comment = User.find(c.user_id)
  			c[:user] = @user_by_comment
  		end
  	end
  end
end
