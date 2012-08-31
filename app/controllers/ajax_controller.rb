class AjaxController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def edit_post
  	begin
		@edit_post = Post.find(params[:id])
		if !params[:content].nil?
			@edit_post.update_attributes(:content => params[:content])
		end
	  	respond_to do |format|
		  format.json { render :json => @edit_post }
		end
  	rescue Exception => e
  		@edit_post = Post.new
	  	respond_to do |format|
		  format.json { render :json => @edit_post }
		end
  	end
  end

end
