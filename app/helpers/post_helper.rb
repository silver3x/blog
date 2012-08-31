module PostHelper
	def post_error
		if !flash[:post_warning].nil? 
			html = '<div class="alert alert-error fade in">'
		    html += '	<button type="button" class="close" data-dismiss="alert">x</button>'
		    html += '	<ul>'
				flash[:post_warning].each do |e| 
		    		html += "	<li>#{e[1]}</li> "
		    	end 
		    	html += '</ul>'
		    html += '</div>'
		elsif !flash[:post_success].nil?
			html = '<div class="alert alert-success fade in">'
		    html += '	<button type="button" class="close" data-dismiss="alert">×</button>'
		    html += flash[:post_success]
		    html += '</div>'
		end
		raw html
	end
end
