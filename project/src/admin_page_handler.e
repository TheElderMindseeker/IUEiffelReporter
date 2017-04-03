note
	description: "Summary description for {ADMIN_PAGE_HANDLER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ADMIN_PAGE_HANDLER

inherit
	WSF_URI_HANDLER


feature
	execute (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Execute handler for `req' and respond in `res'.
		local
			--path:PATH
		do
			--create path.make_current
--			create to_send.make (req)
			res.put_string ("some string")
		end
end
