note
	description: "class for giving to admin data to export"
	author: "Ginatullin Niyaz"
	date: "24.04.2017"
	revision: "1.0"

class
	EXPORT_HANDLER

inherit

	WSF_STARTS_WITH_HANDLER

create
	make

feature

	make
		do
			create page.make
		end

feature

feature

	execute (a_start_path: READABLE_STRING_8; req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Execute handler for `req' and respond in `res'.
			-- delete report with some id (path contains this id)
		local
			query_manager: QUERY_MANAGER
			s_id: STRING
			--path_components: LIST [READABLE_STRING_32]
			file:WSF_DOWNLOAD_RESPONSE
		do
			create file.make ("input.txt")
--			page.set_status_code ({HTTP_STATUS_CODE}.ok)
--			create query_manager.make
--			if req.is_get_request_method then
--				--path_components := req.path_info.split ('/')
--				--s_id := create {STRING}.make_from_string (path_components.i_th (3))
--			end
			res.send (file)
		end

feature {NONE} -- Implementation

	page: WSF_HTML_PAGE_RESPONSE

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
