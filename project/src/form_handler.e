note
	description: "Summary description for {FORM_HANDLER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	FORM_HANDLER

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

	execute (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Execute handler for `req' and respond in `res'.
		local
			temp_form: TEMPLATE_FORM
			form_parser:FORM_PARSER
			str: STRING
		do
			page.set_status_code ({HTTP_STATUS_CODE}.bad_request)
			if req.request_method.same_string ("GET") then
				page.set_status_code ({HTTP_STATUS_CODE}.ok)
				create temp_form
				if attached temp_form.output as body then
					page.set_body (body)
				end
				res.send (page)
			elseif req.request_method.same_string ("POST") then
				if attached req.content_length as con_len then
					if con_len.to_integer_32 > 0 then
						page.set_status_code ({HTTP_STATUS_CODE}.ok)
						create str.make (con_len.to_integer_32)
						req.read_input_data_into (str)
						create form_parser.make(str)
					end
				end
			end
		end

feature {NONE}

	page: WSF_HTML_PAGE_RESPONSE

end
