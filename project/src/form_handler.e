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
			parser:JSON_PARSER
			str:STRING
		do
			page.set_status_code ({HTTP_STATUS_CODE}.bad_request)
			if attached req.content_length as con_len then
				if con_len.to_integer_32 > 0 then
					page.set_status_code ({HTTP_STATUS_CODE}.ok)
					create str.make (con_len.to_integer_32)
					req.read_input_data_into (str)
					create parser.make_with_string (str)
					parser.parse_content
					if parser.is_parsed and then parser.is_valid and then attached parser.parsed_json_value as jv then
						if attached {JSON_OBJECT} jv as j_object then
							--make it in a across
							across list_of_variables as l loop
								if attached {JSON_OBJECT} j_object.item (l.item) as j_value then
									print("key: " + l.item + "value: " + j_value.representation + "%N")
								end
							end
						end
					end
				end
			end
			res.send (page)
		end

feature
	page:WSF_HTML_PAGE_RESPONSE

	list_of_variables:LINKED_LIST[STRING]
	once
		create Result.make
		Result.force("name")
		Result.force("date")
	end
end
