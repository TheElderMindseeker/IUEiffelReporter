note
	description: "Summary description for {STUDENT}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	STUDENT

create
	make

feature

	make (a_student_name: STRING; a_nature_of_work: STRING; a_id: INTEGER)
			-- creates report about some unit, that contains a lot general information abut this report
		require
			a_student_name /= Void
			a_nature_of_work /= Void
		do
			student_name := a_student_name
			nature_of_work := a_nature_of_work
			id := a_id
		ensure
			student_name.same_string(a_student_name)
			nature_of_work.same_string(a_nature_of_work)
			id = a_id
		end

	id: INTEGER

	student_name: STRING

	nature_of_work: STRING

end
