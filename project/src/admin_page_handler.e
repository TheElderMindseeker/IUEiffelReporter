note
	description: "handels administrator's panel"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ADMIN_PAGE_HANDLER

inherit
	WSF_URI_HANDLER

create
	make

feature

	make
	do
		create page.make
	end
feature
	page:WSF_HTML_PAGE_RESPONSE

feature
	execute (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Execute handler for `req' and respond in `res'.
			-- returns administator panel
		local
			temp:TEMPLATE_ADMIN_PAGE
		do
			page.set_status_code ({HTTP_STATUS_CODE}.ok)
			create temp
			if attached temp.get_output as body then
				page.set_body(body)
			end
			res.send (page)
		end
end
