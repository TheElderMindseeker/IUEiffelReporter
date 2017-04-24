note
	description: "Handels page that returns detailed information about some report."
	author: "Niyaz Ginatullin"
	date: "10.04.2017"
	revision: "1.0"

class
	ADMIN_MORE_INFO_PAGE_HANDLER

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
			-- returns more information about some report
		local
			template: TEMPLATE_MORE_INFO
			s_id: STRING
			query_manager: QUERY_MANAGER
		do
			page.set_status_code ({HTTP_STATUS_CODE}.ok)
			if req.is_get_request_method then
				s_id := create {STRING}.make_from_string (req.path_info.split ('/').i_th (3))
				if s_id.is_integer and then attached s_id.to_integer as id then
					create query_manager.make
					if query_manager.database_manager.has_report (id) then
						create template.make (id)
						if attached template.output as body then
							res.put_string (body)
						end
					else
						not_found_page (id.to_hex_string, req, res)
					end
				else
					incorrect_path (req, res)
				end
			end
		end

	not_found_page (id: READABLE_STRING_8; req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			not_found: WSF_NOT_FOUND_RESPONSE
		do
			create not_found.make (req)
			not_found.set_body ("There is no such report")
			res.send (not_found)
		end

	incorrect_path (req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			not_found: WSF_NOT_FOUND_RESPONSE
		do
			create not_found.make (req)
			not_found.set_body ("you path is incorrect")
			res.send (not_found)
		end

end
