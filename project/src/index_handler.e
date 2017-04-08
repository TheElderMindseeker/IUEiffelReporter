note
	description: "Summary description for {INDEX_HANDLER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	INDEX_HANDLER

inherit

	WSF_URI_HANDLER

create
	make

feature

	make
		do
		end

feature

	execute (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Execute handler for `req' and respond in `res'.
			-- returns administator panel
		local
			temp: TEMPLATE_INDEX_PAGE
		do
			create temp
			if attached temp.output as body then
				res.put_string (body)
			end
		end

end
