note
	description: "Summary description for {RELEVANT_INFO}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	RELEVANT_INFO

create
	make

feature

	make (a_relevant_info: STRING)
		require
			a_relevant_info /= Void
		do
			relevant_info := a_relevant_info
		ensure
			relevant_info.same_string (a_relevant_info)
		end

	relevant_info: STRING

end
