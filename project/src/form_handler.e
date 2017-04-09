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
			create page.make
		end

feature

	execute (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Execute handler for `req' and respond in `res'.
			-- returns form if GET request
			-- handles json data if POST request
		local
			temp_form: TEMPLATE_FORM
			form_parser: FORM_PARSER
			input_data: STRING
			query_manager: QUERY_MANAGER
			database_manager: DATABASE_MANAGER
		do
			create query_manager.make
			database_manager := query_manager.database_manager
			if req.is_get_request_method then
				create temp_form
				if attached temp_form.output as body then
					res.put_string (body)
				end
			elseif req.is_post_request_method then
				if attached req.content_length as con_len then
					if con_len.to_integer_32 > 0 then
						page.set_status_code ({HTTP_STATUS_CODE}.ok)
						create input_data.make (con_len.to_integer_32)
						req.read_input_data_into (input_data)
						create form_parser.make (input_data, database_manager)
						form_parser.parse
						if attached form_parser.parse_result as parsed_data then
							if attached {LINKED_LIST [FIELD]} parsed_data.at ("reports") as report_data then
								database_manager.create_report (report_data)
							end
							parsed_data.remove ("reports")
							across
								parsed_data.current_keys as table_name
							loop
								if attached {LINKED_LIST [FIELD]} parsed_data.at (table_name.item) as record then
									database_manager.single_insert (table_name.item, record)
								elseif attached {LINKED_LIST [LINKED_LIST [FIELD]]} parsed_data.at (table_name.item) as record_list then
									--adds report_id to each LINKED_LIST[FIELD]
									add_id_field_to_linked_lists(database_manager.current_report_id, record_list, database_manager)
									database_manager.multiple_insert (table_name.item, record_list)
								end
							end
						end
					end
				end
			end
			query_manager.database_manager.close -- Without this, "database is locked" bug is present
		end

feature {NONE} -- Implementation

	page: WSF_HTML_PAGE_RESPONSE

feature {NONE}

	add_id_field_to_linked_lists (id: INTEGER; linked_lists: LINKED_LIST [LINKED_LIST [FIELD]]; database_manager:DATABASE_MANAGER)
			-- Add field id to each linked list at linked_lists
		local
			field: detachable FIELD
		do
			field := database_manager.create_field ("report_id", id)
			across
				linked_lists as linked_list
			loop
				if attached field as att_field then
					linked_list.item.extend (att_field)
				end
			end
		end
end
