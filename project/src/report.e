note
	description: "Summary description for {REPORT}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	REPORT

create make

feature
	make(a_name:STRING; a_head:STRING; a_start_date:STRING; a_end_date:STRING)
	do
		name:=a_name
		head:=a_head
		start_date:=a_start_date
		end_date:=a_end_date
	end

	name:STRING
	head:STRING
	start_date:STRING
	end_date:STRING
end
