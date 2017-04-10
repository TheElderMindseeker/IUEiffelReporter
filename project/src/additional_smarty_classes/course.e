note
	description: "Additional class"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	COURSE

create
	make

feature

	make (a_course_name: STRING; a_semester: STRING; a_edu_level: STRING; a_num_students: STRING)
			-- creates report about some unit, that contains a lot general information abut this report
		require
			a_course_name /= Void
			a_semester /= Void
			a_edu_level /= Void
			a_num_students /= Void
		do
			course_name := a_course_name
			semester := a_semester
			edu_level := a_edu_level
			num_students := a_num_students
		ensure
			course_name.same_string(a_course_name)
			semester.same_string(a_semester)
			edu_level.same_string(a_edu_level)
			num_students.same_string(a_num_students)
		end

	course_name: STRING

	semester: STRING

	edu_level: STRING

	num_students: STRING

end
