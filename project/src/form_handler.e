note
	description: " handels form page"
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
		end

feature

	execute (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Execute handler for `req' and respond in `res'.
			-- returns form if GET request
			-- handles json data if POST request
		local
			temp_form: TEMPLATE_FORM
			form_parser: FORM_PARSER
			str: STRING
		do
			if req.is_get_request_method then
				create temp_form
				if attached temp_form.output as body then
					res.put_string (body)
				end
			elseif req.is_post_request_method then
				if attached req.content_length as con_len then
					if con_len.to_integer_32 > 0 then
						create str.make (con_len.to_integer_32)
						req.read_input_data_into (str)
						create form_parser.make
						form_parser.parse_and_add_to_db (str)
					end
				end
			end
		end

end
