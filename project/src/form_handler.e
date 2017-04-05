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
			parser: JSON_PARSER
			str: STRING
			--			printer: JSON_PRETTY_STRING_VISITOR
			--			for_print:STRING
		do
			page.set_status_code ({HTTP_STATUS_CODE}.bad_request)
			if req.request_method.same_string ("GET") then
				page.set_status_code ({HTTP_STATUS_CODE}.ok)
				create temp_form
				if attached temp_form.output as body then
					page.set_body (body)
				end
				res.send (page)
			else --if req.request_method.same_string ("POST") then
				if attached req.content_length as con_len then
					if con_len.to_integer_32 > 0 then
						page.set_status_code ({HTTP_STATUS_CODE}.ok)
						create str.make (con_len.to_integer_32)
						req.read_input_data_into (str)
						create parser.make_with_string (str)
						parser.parse_content
						if parser.is_parsed and then parser.is_valid and then attached parser.parsed_json_value as jv then
							if attached {JSON_OBJECT} jv as j_object then
								across
									j_object.current_keys as j_key
								loop
									if attached {JSON_STRING} j_object.item (j_key.item) as j_string and then not j_string.representation.same_string ("%"%"") then
										print ("key of string: " + j_key.item.representation + " string: " + j_string.representation + "%N")
									else
											--do "all bad"
									end
									if attached {JSON_ARRAY} j_object.item (j_key.item) as j_array then
										print ("name of array: " + j_key.item.representation + " values in array:%N")
										if j_array.count > 1 then
											across
												j_array.array_representation as ar_item
											loop
												if attached {JSON_OBJECT} ar_item.item as ar_object then
													across
														ar_object.current_keys as ar_key
													loop
														if attached {JSON_STRING} ar_object.item (ar_key.item) as ar_string and then not ar_string.representation.same_string ("%"%"") then
															print ("key of string in array: " + ar_key.item.representation + " string: " + ar_string.representation + "%N")
														end
													end
												end
											end
										else
												--do "all bad"
										end
									end
								end
							end
						end
					end
				end
			end
		end

feature

	page: WSF_HTML_PAGE_RESPONSE

		--name of array: courses-taught{"name":"corse name 1","semester":"s","level":"l","numofst":"1"}
		--{"name":"course name 2","semester":"s","level":"l","numofst":"2"}
		--{"name":"course name 3","semester":"s3","level":"l3","numofst":"3"}
		--{"name":"","semester":"","level":"","numofst":""}
		--{"name":"corse name 1","semester":"s","level":"l","numofst":"1"}
		--"courses-taught": [
		--                {
		--                        "name": "corse name 1",
		--                        "semester": "s",
		--                        "level": "l",
		--                        "numofst": "1"
		--                },
		--                {
		--                        "name": "course name 2",
		--                        "semester": "s",
		--                        "level": "l",
		--                        "numofst": "2"
		--                },
		--                {
		--                        "name": "course name 3",
		--                        "semester": "s3",
		--                        "level": "l3",
		--                        "numofst": "3"
		--                },
		--                {
		--                        "name": "",
		--                        "semester": "",
		--                        "level": "",
		--                        "numofst": ""
		--                }
		--        ],

end
