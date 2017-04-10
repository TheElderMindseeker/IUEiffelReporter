note
	description: "This class is additional class for creating template. It contains attributes only"
	author: "Niyaz Ginatullin"
	date: "10.04.2017"
	revision: "1.0"

class
	STUDENT

create
	make

feature

	make (a_student_name: STRING; a_nature_of_work: STRING)
			-- creates report about some unit, that contains a lot general information abut this report
		require
			a_student_name /= Void
			a_nature_of_work /= Void
		do
			student_name := a_student_name
			nature_of_work := a_nature_of_work
		ensure
			student_name.same_string (a_student_name)
			nature_of_work.same_string (a_nature_of_work)
		end

	student_name: STRING

	nature_of_work: STRING

end
