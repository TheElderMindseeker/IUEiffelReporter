note
	description: "Summary description for {ADMIN_DELETE_HANDLER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ADMIN_DELETE_HANDLER

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
			-- returns administator panel
		local
			query_manager:QUERY_MANAGER
		do
			create query_manager.make
			page.set_status_code ({HTTP_STATUS_CODE}.ok)
			if req.is_get_request_method then
				if attached req.path_parameter ("id") as wsf_value_id and then attached wsf_value_id.string_representation.to_integer as id then
					if query_manager.database_manager.has_report (id) then
						--TODO iterate across all table names and multiple_delete
					end
				end
			end
			res.send (page)
		end

end
