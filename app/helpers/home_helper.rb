module HomeHelper
	def set_active (page, current)
		if page == current
			"class='active'"
		end
	end

	def set_sidebar
		if session[:login].nil?
			render "user/login"
		else
			render :partial => "user/info", :locals => {:avatar => @avatar}
		end
	end

	def set_header
		if session[:login].nil?
			html = '<ul class="nav">'
			html+='	<li  #{set_active ("home",@page)} >'
			html+=	link_to "Home", root_path 
			html+=	"</li>"
			html+=	'<li #{set_active ("signup",@page)} >'
			html+=	link_to "Sign Up", signup_path
			html+=	"</li>"
			html+=	"</ul>"
		else
			html = '<ul class="nav">'
			html+= '<li  #{set_active ("home",@page)} >'
			html+=	link_to "Home", root_path 
			html+=	"</li>"
			html+=	"</ul>"
			html+=    '<div class="btn-group" style="float:right;">'
			html+=		link_to session[:login], profile_path , :class => "btn"
			html+=	   '<button class="btn dropdown-toggle" data-toggle="dropdown">'
			html+=	   '<span class="caret"></span>'
			html+=	   '</button>'
			html+=	   '<ul class="dropdown-menu">'
			html+=		"<li>"
			html+=		link_to "Edit Profile", profile_path
			html+=		"</li>"
			html+=		"<li>"
			html+=		link_to "Sign Out", logout_path
			html+=		"</li>"
			html+=	   '</ul>'
			html+=    '</div>'
		end
		raw html
	end

	def change_date (date)
		date.getlocal.strftime("%I:%M%p - %d/%m/%Y")
	end

	def show_date(created, updated, id)
		if created == updated
			html = "<small style='float:right;'><i id='date_#{id}'></i></small>"
			html += "<small style='float:right;'>Post At : #{change_date(created)}</small>"
		else
			html = "<small style='float:right;'><i id='date_#{id}'>&nbsp;&nbsp;&nbsp;(Edit At : #{change_date(updated)}) </i></small>"
		    html +="<small style='float:right;'>Post At : #{change_date(created)}</small>"
		end
		raw html
	end

	def this_owner? (username,id)
		if session[:login] == username
			image_edit = image_tag "/images/edit.png", :width => "20"
			image_delete = image_tag "/images/delete.png", :width => "20"
			html = '<div style="float:right;">'
			html+=	link_to image_edit, "javascript:;", :onclick => "show_edit_post(#{id})"
			html+= " "
    		html+=	link_to image_delete), delete_post_path(id), :onclick => "return confirm('Are you sure ?')"
    		html+=  '</div>'
		end
		raw html
	end
end
