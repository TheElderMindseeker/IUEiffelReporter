note
	description: "Summary description for {ADMIN_PAGE_HANDLER}."
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
		local
			temp:TEMPLATE_FORM
		do
			create temp
			--create path.make_current
--			create to_send.make (req)
			if attached temp.output as body then
				page.set_body(body)
			end
			res.send (page)
		end
end
