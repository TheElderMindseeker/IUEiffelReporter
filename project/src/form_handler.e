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

	make (manager: DATABASE_MANAGER)
		do
			create page.make
			database_manager := manager
		end

feature

	execute (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Execute handler for `req' and respond in `res'.
		local
			temp_form: TEMPLATE_FORM
			form_parser: FORM_PARSER
			input_data: STRING
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
						create input_data.make (con_len.to_integer_32)
						req.read_input_data_into (input_data)
						create form_parser.make (input_data, database_manager)
						form_parser.parse
						if attached form_parser.parse_result as parsed_data then
							across
								parsed_data.current_keys as table_name
							loop
								if attached {LINKED_LIST [FIELD]} parsed_data.at (table_name.item) as record then
									database_manager.single_insert (table_name.item, record)
								elseif attached {LINKED_LIST [LINKED_LIST [FIELD]]} parsed_data.at (table_name.item) as record_list then
									database_manager.multiple_insert (table_name.item, record_list)
								end
							end
						end
					end
				end
			end
		end

feature {NONE} -- Implementation

	page: WSF_HTML_PAGE_RESPONSE

	database_manager: DATABASE_MANAGER
			-- Database manager for parsing the user form

end
