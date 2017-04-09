note
	description: "handels administrator's panel"
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
		end

feature

	execute (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Execute handler for `req' and respond in `res'.
			-- returns administator panel
		local
			temp: TEMPLATE_ADMIN_PAGE
			admin_parser:ADMIN_PAGE_PARSER
			input_data:STRING
		do
			if req.is_get_request_method then
				create temp
				if attached temp.output as body then
					res.put_string (body)
				end
			elseif req.is_post_request_method then
				if attached req.content_length_value as con_len then
					create input_data.make (con_len.to_integer_32)
					req.read_input_data_into (input_data)
					create admin_parser.make (input_data)
					admin_parser.parse
				end
			end
		end

end
