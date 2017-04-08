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

feature -- Router

	setup_router
			-- Setup `router'
		local
			fhdl: WSF_FILE_SYSTEM_HANDLER
		do
			create fhdl.make_with_path (create {PATH}.make_from_string ("www"))
			fhdl.set_directory_index (<<"index.html">>)
			router.handle ("/admin", create{ADMIN_PAGE_HANDLER}.make, router.methods_get_post)
			router.handle ("/admin/delete", create{ADMIN_DELETE_HANDLER}.make, router.methods_get_post)
			router.handle ("/admin/edit", create{ADMIN_EDIT_PAGE_HANDLER}.make, router.methods_get_post)
			router.handle ("/admin/more_info", create{ADMIN_MORE_INFO_PAGE_HANDLER}.make, router.methods_get_post)
			router.handle ("/form", create{FORM_HANDLER}.make, router.methods_get_post)
			router.handle ("", fhdl, router.methods_get_post)
		end

end
