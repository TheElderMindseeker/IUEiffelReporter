note
	description: "Summary description for {WSF_OUR_RESPONSE_MESSAGE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	WSF_OUR_RESPONSE_MESSAGE

inherit
	WSF_RESPONSE_MESSAGE

feature

	send_to(res:WSF_RESPONSE)
	do
		res.set_status_code (200)
		res.put_string ("our_string")
	end
end
