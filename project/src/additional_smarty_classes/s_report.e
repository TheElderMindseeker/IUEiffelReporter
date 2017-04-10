note
	description: "This class is additional class for creating template. It contains attributes only"
	author: "Niyaz Ginatullin"
	date: "10.04.2017"
	revision: "1.0"

class
	S_REPORT

create
	make

feature

	make (a_student_name: STRING; a_title: STRING; a_publication_plans: STRING)
			-- creates report about some unit, that contains a lot general information abut this report
		require
			a_student_name /= Void
			a_title /= Void
			a_publication_plans /= Void
		do
			student_name := a_student_name
			title := a_title
			publication_plans := a_publication_plans
		ensure
			student_name.same_string (a_student_name)
			title.same_string (a_title)
			publication_plans.same_string (a_publication_plans)
		end

	student_name: STRING

	title: STRING

	publication_plans: STRING

end
