note
	description: "Summary description for {REPORT_RECORD}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	REPORT_RECORD

create
	make

feature

	make (a_name: STRING; a_head: STRING; a_start_date: STRING; a_end_date: STRING)
			-- Initialize `Current'.
		require
			a_name /= Void
			a_head /= Void
			a_start_date /= Void
			a_end_date /= Void
		do
			name := a_name
			head := a_head
			start_date := a_start_date
			end_date := a_end_date
		ensure
			name = a_name
			head = a_head
			start_date = a_start_date
			end_date = a_end_date
		end

	name: STRING
			-- Unit name.

	head: STRING
			-- Unit head name.

	start_date: STRING
			-- Report period starting date

	end_date: STRING
			-- Report period ending date

end
