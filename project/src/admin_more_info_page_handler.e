note
	description: "Summary description for {ADMIN_MORE_INFO_PAGE_HANDLER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

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
			template:TEMPLATE_MORE_INFO
			s_id:STRING
		do
			page.set_status_code ({HTTP_STATUS_CODE}.ok)
			if req.is_get_request_method then
				s_id:= create{STRING}.make_from_string (req.path_info.substring (a_start_path.count+2, req.path_info.count))
				if attached s_id.to_integer as id then
					create template.make(id)
					if attached template.output as body then
						res.put_string(body)
					end
				end
			end
		end

end
