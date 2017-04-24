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
				create temp_form.make (-1)
				if attached temp_form.output as body then
					res.put_string (body)
				end
			elseif req.is_post_request_method then
				if attached req.content_length_value as con_len then
					if con_len > 0 then
						page.set_status_code ({HTTP_STATUS_CODE}.ok)
						create input_data.make (con_len.to_integer_32)
						req.read_input_data_into (input_data)
						create form_parser.make (input_data, database_manager)
						form_parser.parse
						if attached form_parser.parse_result as parsed_data then
							if attached {LINKED_LIST [FIELD]} parsed_data.at ("reports") as report_data then
								if form_parser.h_id > 0 then
									delete_report (form_parser.h_id, query_manager.database_manager, res, req)
								end
								database_manager.create_report (report_data)
							end
							parsed_data.remove ("reports")
							across
								parsed_data.current_keys as table_name
							loop
								if attached {LINKED_LIST [FIELD]} parsed_data.at (table_name.item) as record then
									if attached database_manager.create_field ("report_id", database_manager.current_report_id) as field then
										record.extend (field)
									end
									database_manager.single_insert (table_name.item, record)
								elseif attached {LINKED_LIST [LINKED_LIST [FIELD]]} parsed_data.at (table_name.item) as record_list then
									add_id_field_to_linked_lists (database_manager.current_report_id, record_list, database_manager)
									database_manager.multiple_insert (table_name.item, record_list)
								end
							end
							res.put_string (database_manager.current_report_id.out)
						end
					end
				end
			end
			query_manager.database_manager.close -- Without this, "database is locked" bug is present
		end

feature {NONE} -- Implementation

	page: WSF_HTML_PAGE_RESPONSE

feature {NONE}

	add_id_field_to_linked_lists (id: INTEGER; linked_lists: LINKED_LIST [LINKED_LIST [FIELD]]; database_manager: DATABASE_MANAGER)
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

	delete_report (id: INTEGER; database_manager: DATABASE_MANAGER; res:WSF_RESPONSE;req:WSF_REQUEST)
		do
			if database_manager.has_report (id) then
				across
					database_manager.list_tables as table_name
				loop
					if database_manager.has_report (id) and not table_name.item.same_string ("reports") then
						database_manager.multiple_delete (table_name.item, id)
					end
				end
				database_manager.multiple_delete ("reports", id)
			else
				not_found_page (id.to_hex_string, res,req)
			end
		end

	not_found_page (id: READABLE_STRING_8; res: WSF_RESPONSE; req:WSF_REQUEST)
		local
			not_found: WSF_NOT_FOUND_RESPONSE
		do
			create not_found.make (req)
			not_found.set_body ("There is no such report")
			res.send (not_found)
		end

end
