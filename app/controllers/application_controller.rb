class ApplicationController < ActionController::Base
  protect_from_forgery
  ActiveRecord::Base.pluralize_table_names = false
  before_filter :info

  private
  def has_login?
    if session[:login].nil? 
      false
    else
      true
    end
  end
  
  def info
    if has_login?
      @user = User.all(:conditions => ["username = ?",session[:login]]).first
      @avatar = @user[:avatar]
      @new_post = Post.new
  end
  end
end
