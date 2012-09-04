class PostController < ApplicationController
  def new
  	@page = "new_post"
  	@title = "New Post"

    if params[:current_path].nil?
      redirect_to root_path
    else
      params[:post][:poster_id] = @user[:user_id]
      @new_post = @user.post.build(params[:post])
      @new_post.save
        if !@new_post.errors.empty?
          flash[:post_warning] = @new_post.errors
        else
          flash[:post_success] = "Post successful !"
        end
      redirect_to params[:current_path]
  end
  end

  def detail
  end

  def edit
  end

  def delete
    if !params[:id].nil?
      begin
        @delete_post = Post.find(params[:id])
        @delete_post.destroy
      rescue Exception => e
        redirect_to flash[:current_page]
        return
      end
    end
    redirect_to flash[:current_page]
  end

end
