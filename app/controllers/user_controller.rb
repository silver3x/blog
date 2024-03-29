class UserController < ApplicationController
  before_filter :require_login, :only => [:profile,:logout]

  def login
    if !params[:data].nil?
      if !params[:data][:username].empty? && !params[:data][:password].empty?
        @user = User.all(:conditions => ["username = ? AND password = ?", params[:data][:username],Digest::MD5.hexdigest(params[:data][:password])])
        if @user.empty?
          flash[:error] = "Wrong username or password !"
          redirect_to root_path
          return
        else
          if @user.first[:user_type] == 1
            session[:admin] = params[:data][:username]
          end
            session[:login] = params[:data][:username]
        end
      else
        flash[:error] = "Please fill username or password !"
        redirect_to root_path
        return
      end
    end
    redirect_to profile_path
  end

  def logout
    session[:login] = nil;
    session[:admin] = nil;
    redirect_to root_path
  end

  def profile
    @page = "profile"
    @title = "Profile"
    if !params[:id].nil?
       @user= User.find(params[:id])
       @id = params[:id]
       if !params[:user].nil?
        begin
          if params[:user][:avatar].nil?
            params[:user][:avatar] = @user[:avatar]
          else
            File.open("#{RAILS_ROOT}/public/data/#{@user[:username]}.png","w+") do |f|
                  f.write params[:user][:avatar].read
            end
            params[:user][:avatar] ="/data/#{@user[:username]}.png"
          end
          if params[:user][:username].nil?
            @user.tmp = {:action => "update", :password => @user[:password]}
          end
          @user.update_attributes(params[:user])
          if @user.errors.empty?
            flash[:success] = 'Update your profile successful !'
            redirect_to user_profile_path(params[:id])
          end
        rescue Exception => e
          flash[:warning] = 'Can not update profile now, please try again !'
        end
       end
      elsif !params[:user].nil?
      begin
        if params[:user][:avatar].nil?
          params[:user][:avatar] = @user[:avatar]
        else
          File.open("#{RAILS_ROOT}/public/data/#{session[:login]}.png","w+") do |f|
                f.write params[:user][:avatar].read
          end
          params[:user][:avatar] ="/data/#{session[:login]}.png"
        end
        if params[:user][:username].nil?
          @user.tmp = {:action => "update", :password => @user[:password]}
        end
        @user.update_attributes(params[:user])
        if @user.errors.empty?
          flash[:success] = 'Update your profile successful !'
          redirect_to profile_path
        end
      rescue Exception => e
        flash[:warning] = 'Can not update profile now, please try again !'
      end
     end 
  end

  def signup
  	@page = "signup"
  	@title = "Sign Up"

  	if !params[:user].nil?
  		@new_user = User.new(params[:user])
  		@new_user.save
      if @new_user.errors.empty?
        session[:login] = params[:user][:username]
        redirect_to profile_path
      end
  	else 
  		@new_user = User.new
  	end
  end

  def delete_user
        if !params[:id].nil?
              @user=User.find(params[:id])
              if @user.destroy
                    flash[:success]= "User deleted!"
                    redirect_to admin_home_path
              else
                    flash[:error]="Failed to delete user!"
                    redirect_to admin_home_path
              end
        end
  end

  private
  def require_login
    if !has_login?
      redirect_to root_path
    end
  end
end
