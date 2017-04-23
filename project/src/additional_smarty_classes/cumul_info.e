note
	description: "Summary description for {CUMUL_INFO}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CUMUL_INFO

create
	make

feature

	make (a_unit_name: STRING; a_head_name: STRING; a_rep_start: STRING; a_rep_end: STRING; a_relevant_info: STRING)
		require
			a_unit_name /= Void
			a_head_name /= Void
			a_rep_start /= Void
			a_rep_end /= Void
			a_relevant_info /= Void
		do
			unit_name := a_unit_name
			head_name := a_head_name
			rep_start := a_rep_start
			rep_end := a_rep_end
			relevant_info := a_relevant_info
		ensure
			a_unit_name.same_string (unit_name)
			a_head_name.same_string (head_name)
			a_rep_start.same_string (rep_start)
			a_rep_end.same_string (rep_end)
			a_relevant_info.same_string (relevant_info)
		end

	unit_name: STRING

	head_name: STRING

	rep_start: STRING

	rep_end: STRING

	relevant_info: STRING

end
