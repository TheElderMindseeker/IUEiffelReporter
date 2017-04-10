note
	description: "This class is additional class for creating template. It contains attributes only"
	author: "Niyaz Ginatullin"
	date: "10.04.2017"
	revision: "1.0"

class
	REPORT

create
	make

feature

	make (a_name: STRING; a_head: STRING; a_start_date: STRING; a_end_date: STRING)
			-- creates report about some unit, that contains a lot general information abut this report
		require
			a_name /= Void
			a_head /= Void
			a_start_date /= Void
			a_end_date /= Void
		do
			unit_name := a_name
			head_name := a_head
			rep_start := a_start_date
			rep_end := a_end_date
		ensure
			unit_name /= Void
			head_name /= Void
			rep_start /= Void
			rep_end /= Void
		end

	unit_name: STRING
			-- name of unit

	head_name: STRING
			-- head of unit

	rep_start: STRING
			-- start of reporting period

	rep_end: STRING
			-- end of reporting period

end
