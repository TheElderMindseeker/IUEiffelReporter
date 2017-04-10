note
	description: ""
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ADMIN_DELETE_HANDLER

inherit

	WSF_STARTS_WITH_HANDLER

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

	execute (a_start_path: READABLE_STRING_8; req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Execute handler for `req' and respond in `res'.
			-- returns administator panel
		local
			query_manager:QUERY_MANAGER
			s_id:STRING
			redirect:WSF_HTML_REDIRECTION_RESPONSE
		do
			page.set_status_code ({HTTP_STATUS_CODE}.ok)
			create query_manager.make
			if req.is_get_request_method then
				s_id:= create{STRING}.make_from_string (req.path_info.substring (a_start_path.count+2, req.path_info.count))
				if attached s_id.to_integer as id then
					if query_manager.database_manager.has_report (id) then
						across
							query_manager.database_manager.list_tables as table_name
						loop
							if query_manager.database_manager.has_report (6) then
								query_manager.database_manager.multiple_delete (table_name.item, id)
							end
						end
					end
				end
			end
			res.send (page)
			query_manager.database_manager.close
			create redirect.make("/admin")
			res.send (redirect)
		end

end
