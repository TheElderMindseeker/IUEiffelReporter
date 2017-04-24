note
	description: "class for giving to admin data to export"
	author: "Ginatullin Niyaz"
	date: "24.04.2017"
	revision: "1.0"

class
	EXPORT_XML_HANDLER

inherit

	WSF_STARTS_WITH_HANDLER

create
	make

feature

	make
		do
		end

feature

feature

	execute (a_start_path: READABLE_STRING_8; req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Execute handler for `req' and respond in `res'.
			-- delete report with some id (path contains this id)
		local
			query_manager: QUERY_MANAGER
			s_id: STRING
			path_components: LIST [READABLE_STRING_32]
			file: WSF_DOWNLOAD_RESPONSE
			file_to_send: PLAIN_TEXT_FILE
			exporter: XML_EXPORTER
		do
			create query_manager.make
			if req.is_get_request_method then
				path_components := req.path_info.split ('/')
				s_id := create {STRING}.make_from_string (path_components.i_th (3))
				if s_id.is_integer and then attached s_id.to_integer as id then
					if query_manager.database_manager.has_report (id) then
						create exporter
						create file_to_send.make_create_read_write ("exports/report-"+id.out+".xml")
						query_manager.database_manager.close
						exporter.set_report_id (id)
						exporter.create_data_file
						if attached exporter.data_file as string then
							file_to_send.put_string (string)
						end
						file_to_send.close
						create file.make ("exports/report-"+id.out+".xml")
						res.send (file)
						file_to_send.delete
					else
						not_found_page (id.to_hex_string, res, req)
					end
				else
					incorrect_path (req, res)
				end
			end
		end

feature {NONE}

	not_found_page (id: READABLE_STRING_8; res: WSF_RESPONSE; req: WSF_REQUEST)
		local
			not_found: WSF_NOT_FOUND_RESPONSE
		do
			create not_found.make (req)
			not_found.set_body ("There is no such report to export")
			res.send (not_found)
		end

	incorrect_path (req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			not_found: WSF_NOT_FOUND_RESPONSE
		do
			create not_found.make (req)
			not_found.set_body ("you path is incorrect")
			res.send (not_found)
		end

end
