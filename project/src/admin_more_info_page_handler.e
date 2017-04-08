note
	description: "Summary description for {ADMIN_MORE_INFO_PAGE_HANDLER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ADMIN_MORE_INFO_PAGE_HANDLER

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

	page: WSF_HTML_PAGE_RESPONSE

feature

	execute (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Execute handler for `req' and respond in `res'.
			-- returns more information about some report
		do
			page.set_status_code ({HTTP_STATUS_CODE}.ok)
			if req.is_get_request_method then
				if attached req.path_parameter ("id") as id then
					--delete form with id id.to_integer
				end
			end
			res.send (page)
		end

end
