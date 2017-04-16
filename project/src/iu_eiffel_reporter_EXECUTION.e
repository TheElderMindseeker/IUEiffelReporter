note
	description: "[
		application execution
	]"
	date: "$Date: 2016-06-29 05:58:45 -0700 (Wed, 29 Jun 2016) $"
	revision: "$Revision: 98966 $"

class
	IU_EIFFEL_REPORTER_EXECUTION

inherit

	WSF_ROUTED_EXECUTION

create
	make

feature {NONE} -- Initialization

feature -- Router

	setup_router
			-- Setup `router'
		local
			fhdl: WSF_FILE_SYSTEM_HANDLER
			query_manager: QUERY_MANAGER
		do
			create fhdl.make_with_path (create {PATH}.make_from_string ("www"))
			create query_manager.make
			fhdl.set_directory_index (<<"index.html">>)
			fhdl.set_not_found_handler (agent not_found_page)
			router.handle ("/edit", create{ADMIN_EDIT_PAGE_HANDLER}.make, router.methods_get_post)
			router.handle ("/delete", create{ADMIN_DELETE_HANDLER}.make, router.methods_get_post)
			router.handle ("/details", create{ADMIN_MORE_INFO_PAGE_HANDLER}.make, router.methods_get_post)
			router.handle ("/admin", create {ADMIN_PAGE_HANDLER}.make, router.methods_get_post)
			router.handle ("/form", create {FORM_HANDLER}.make, router.methods_get_post)
			router.handle ("", fhdl, router.methods_get_post)
			query_manager.database_manager.close
		end

feature{NONE}
	not_found_page(uri: READABLE_STRING_8; req: WSF_REQUEST; res: WSF_RESPONSE)
	local
		not_found:WSF_NOT_FOUND_RESPONSE
	do
		create not_found.make (req)
		not_found.set_body ("There is no such resourse")
		res.send (not_found)
	end
end
