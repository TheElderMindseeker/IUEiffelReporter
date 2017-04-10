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
			path_components:LIST[READABLE_STRING_32]
		do
			page.set_status_code ({HTTP_STATUS_CODE}.ok)
			if req.is_get_request_method then
				path_components := req.path_info.split ('/')
				s_id:= create{STRING}.make_from_string (path_components.i_th(3))
				if attached s_id.to_integer as id then
					create template.make (id)
					if attached template.output as body then
						res.put_string (body)
					end
				end
			end
		end

end
