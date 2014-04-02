module ApplicationHelper

	# returns a properly formatted dynamic title for each page
	def full_title(page_title)
		base_title = "Real Estate App"
		if page_title.empty?
			base_title
		else
			"#{base_title} | #{page_title}"
		end
	end

end
