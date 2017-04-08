note
	description: "Summary description for {GRANT}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GRANT

create
	make

feature

	make (a_project_title: STRING; a_granting_agency: STRING; a_start_date: STRING; a_end_date: STRING; a_is_continuation: STRING; a_amount: STRING; a_id: INTEGER)
			-- creates report about some unit, that contains a lot general information abut this report
		require
			a_project_title /= Void
			a_granting_agency /= Void
			a_start_date /= Void
			a_end_date /= Void
			a_is_continuation /= Void
			a_amount /= Void
		do
			project_title := a_project_title
			granting_agency := a_granting_agency
			start_date := a_start_date
			end_date := a_end_date
			is_continuation := a_is_continuation
			amount := a_amount
			id := a_id
		ensure
			project_title.same_string(a_project_title)
			granting_agency.same_string(a_granting_agency)
			start_date.same_string(a_start_date)
			end_date.same_string(a_end_date)
			is_continuation.same_string(a_is_continuation)
			amount.same_string(a_amount)
			id = a_id
		end

	id: INTEGER

	project_title: STRING

	granting_agency: STRING

	start_date: STRING

	end_date: STRING

	is_continuation: STRING

	amount: STRING

end
