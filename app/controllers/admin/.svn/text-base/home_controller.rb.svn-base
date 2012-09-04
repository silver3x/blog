module Admin
  class HomeController < ApplicationController
    before_filter :require_login
    def index
     @page  = "AdminManage"
     @user = User.all
    end
    
 private

  def require_login
    if session[:admin].nil?
      redirect_to root_path
    end
  end
  end
end