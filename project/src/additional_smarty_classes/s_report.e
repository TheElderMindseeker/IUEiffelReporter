note
	description: "Summary description for {S_REPORT}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	S_REPORT

create
	make

feature

	make (a_student_name: STRING; a_title: STRING; a_publication_plans: STRING; a_id: INTEGER)
			-- creates report about some unit, that contains a lot general information abut this report
		require
			a_student_name /= Void
			a_title /= Void
			a_publication_plans /= Void
		do
			student_name := a_student_name
			title := a_title
			publication_plans := a_publication_plans
			id := a_id
		ensure
			student_name.same_string(a_student_name)
			title.same_string(a_title)
			publication_plans.same_string(a_publication_plans)
			id = a_id
		end

	id: INTEGER

	student_name: STRING

	title: STRING

	publication_plans: STRING

end
