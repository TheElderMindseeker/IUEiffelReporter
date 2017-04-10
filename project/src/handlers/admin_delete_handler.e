note
	description: "Handles deletion of some report"
	author: "Niyaz Ginatullin"
	date: "10.04.2017"
	revision: "1.0"

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
			-- delete report with some id (path contains this id)
		local
			query_manager:QUERY_MANAGER
			s_id:STRING
			path_components: LIST [READABLE_STRING_32]
		do
			page.set_status_code ({HTTP_STATUS_CODE}.ok)
			create query_manager.make
			if req.is_get_request_method then
				path_components := req.path_info.split ('/')
				s_id:= create{STRING}.make_from_string (path_components.i_th(3))
				if attached s_id.to_integer as id then
					if query_manager.database_manager.has_report (id) then
						across
							query_manager.database_manager.list_tables as table_name
						loop
							if query_manager.database_manager.has_report (id) and not table_name.item.same_string("reports") then
								query_manager.database_manager.multiple_delete (table_name.item, id)
							end
						end
						query_manager.database_manager.multiple_delete ("reports", id)
					end
				end
			end
			res.send (page)
			query_manager.database_manager.close
		end

end
