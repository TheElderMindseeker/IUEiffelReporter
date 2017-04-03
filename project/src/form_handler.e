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
			json:JSON_PARSER
			str:STRING
			int:INTEGER
		do
			page.set_status_code ({HTTP_STATUS_CODE}.bad_request)
			if attached req.content_length as con_len then
				if con_len.to_integer_32 > 0 then
					page.set_status_code ({HTTP_STATUS_CODE}.ok)
					create str.make (con_len.to_integer_32)
					req.read_input_data_into (str)
					create json.make_with_string (str)
					json.parse_content
					if json.is_parsed and then parser.is_valid and then attached parser.parsed_json_value as jv then
						if attached {JSON_OBJECT} jv as j_object then
							--make it in a across
							if attached {JSON_OBJECT} j_object.item ("name") as j_name then
								--to data base
							end
						end
					end
				end
			end
			res.send (page)
		end

feature
	page:WSF_HTML_PAGE_RESPONSE
end
