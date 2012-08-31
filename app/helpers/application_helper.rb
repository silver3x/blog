module ApplicationHelper
	def show_title (title)
		if title.nil? 
			"Blog Sunflower"
		else  
			"Blog Sunflower | " + title
		end
	end
end
