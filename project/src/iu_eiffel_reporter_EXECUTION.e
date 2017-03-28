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
		do
				--| As example:
				--|   /doc is dispatched to self documentated page
				--|   /* are dispatched to serve files/directories contained in "www" directory

				--| Self documentation
			router.handle ("/doc", create {WSF_ROUTER_SELF_DOCUMENTATION_HANDLER}.make (router), router.methods_GET)

				--| Files publisher
			create fhdl.make_hidden ("www")
			fhdl.set_directory_index (<<"index.html">>)
			router.handle ("", fhdl, router.methods_GET)
		end

--not_found_handler(uri:STRING ; req: WSF_REQUEST; res:WSF_RESPONSE)
--		local
--			message: WSF_NOT_FOUND_RESPONSE
--		do
--			create message.make (req)
--			res.send (message)
--		end

--feature -- Router

--	setup_router
--      -- Create a router to dispatch incoming requests to the file system
--    local
--      handler: WSF_FILE_SYSTEM_HANDLER
--    do
--        -- Only make files in "www" directory available
--      create handler.make_with_path (create {PATH}.make_from_string ("www"))
--        -- Set the first page to index.html
--      handler.set_directory_index (<<"index.html">>)
--      handler.set_not_found_handler (agent not_found_handler)
--      --handler.set_not_found_handler (<<"not_found.html">>)
--      --router.handle ("", handler, router.methods_post)
--    end
end
