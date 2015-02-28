module ApplicationHelper

	#return a full title on a per-page base
	def full_title(page_title = "")
		base_title = "Follow Me"
		if page_title.empty?
			base_title
		else
			"#{page_title} | #{base_title}"
		end
	end
end
