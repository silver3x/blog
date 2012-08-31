class User < ActiveRecord::Base
	attr_accessor :tmp
	self.primary_key = :user_id
	has_many :post
	has_many :comment, :through => :post
	validates_confirmation_of :password, :message => 'Password doesn\'t match !', :if => :not_update_profile?
	validates_presence_of :password_confirmation, :message => 'Re-password is blank !', :if => :not_update_profile?
	validates_presence_of :username, :message => 'Email is blank !', :on => :create
	validates_presence_of :password, :message => 'Password is blank !', :if => :not_update_profile?
	validates_uniqueness_of :username, :case_sensitive => false, :message => 'Email had exist !', :on => :create
	validates_format_of :username, :with => /^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$/, :message => "Email isn't invalid !", :on => :create
	validates_length_of :password, :in => 6..20, :message => 'Password has 6 to 20 characters !', :if => :not_update_profile?
	validates_length_of :username, :maximum => 50, :message => 'Email has 50 characters maximum !', :on => :create
	before_save :md5_password
	private
	def md5_password
		if !@tmp.nil?
			if @tmp[:action] == "update" && self[:password] == ""
				self[:password]= @tmp[:password] 
			else
				self[:password]= Digest::MD5.hexdigest(self[:password])
			end
		else
			self[:password]= Digest::MD5.hexdigest(self[:password])
		end
	end

	def not_update_profile?
		if !@tmp.nil?
			if @tmp[:action] == "update" && self[:password] == ""
				false
			else
				true
			end
		else
			true
		end
	end
end
