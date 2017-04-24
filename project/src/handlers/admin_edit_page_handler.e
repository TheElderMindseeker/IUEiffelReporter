note
	description: "handler for editig reports"
	author: "Ginatullin Niyaz"
	date: "24.04.2017"
	revision: "1.0"

class
	ADMIN_EDIT_PAGE_HANDLER

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
			template: TEMPLATE_FORM
			query_manager: QUERY_MANAGER
			s_id: STRING
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
						not_found_page (req, res, id)
					end
					query_manager.database_manager.close
				else
					incorrect_path (req, res)
				end
			end
		end

	not_found_page (req: WSF_REQUEST; res: WSF_RESPONSE; id:INTEGER)
			-- send if there is no report with such id
		local
			not_found: WSF_NOT_FOUND_RESPONSE
		do
			create not_found.make (req)
			not_found.set_body ("There is no such report with id: " + id.out)
			res.send (not_found)
		end

	incorrect_path (req: WSF_REQUEST; res: WSF_RESPONSE)
			--send if path is wrong
		local
			not_found: WSF_NOT_FOUND_RESPONSE
		do
			create not_found.make (req)
			not_found.set_body ("you path is incorrect")
			res.send (not_found)
		end

end
