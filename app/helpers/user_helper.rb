module UserHelper
	def signup_error
		if !@new_user.errors.empty? 
			html = '<div class="alert alert-error fade in">'
		    html += '	<button type="button" class="close" data-dismiss="alert">x</button>'
		    html += '	Errors :'
		    html += '	<ul>'
				@new_user.errors.each do |e| 
		    		html += "	<li>#{e[1]}</li> "
		    	end 
		    	html += '</ul>'
		    html += '</div>'
		end
		raw html
	end

	def status_input(current)
		if !@new_user.errors[current].empty?
			raw 'class="control-group error"'
		else
			raw 'class="control-group"'
		end
	end

	def login_error 
		if !flash[:error].nil?
			html = '<div class="alert alert-error fade in">'
		    html += '<button type="button" class="close" data-dismiss="alert">x</button>'
		    html += flash[:error]
		    html += '</div>'
		end
		raw html
	end

	def show_avatar(avatar)
		if avatar.nil?
			"#"
		else
			avatar
		end
	end

	def profile_error
		if !@user.errors.empty? 
			html = '<div class="alert alert-error fade in">'
		    html += '	<button type="button" class="close" data-dismiss="alert">x</button>'
		    html += '	Errors :'
		    html += '	<ul>'
				@user.errors.each do |e| 
		    		html += "	<li>#{e[1]}</li> "
		    	end 
		    	html += '</ul>'
		    html += '</div>'
		elsif !flash[:success].nil?
			html = '<div class="alert alert-success fade in">'
		    html += '	<button type="button" class="close" data-dismiss="alert">x</button>'
		    html += flash[:success]
		    html += '</div>'
		elsif !flash[:warning].nil?
			html = '<div class="alert alert-warning fade in">'
		    html += '	<button type="button" class="close" data-dismiss="alert">x</button>'
		    html += flash[:warning]
		    html += '</div>'
		end
		raw html
	end
end
