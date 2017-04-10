note
	description: "This class is additional class for creating template. It contains attributes only"
	author: "Niyaz Ginatullin"
	date: "10.04.2017"
	revision: "1.0"

class
	EXAM

create
	make

feature

	make (a_course_name: STRING; a_semester: STRING; a_exam_kind: STRING; a_num_students: STRING)
			-- creates report about some unit, that contains a lot general information abut this report
		require
			a_course_name /= Void
			a_semester /= Void
			a_exam_kind /= Void
			a_num_students /= Void
		do
			course_name := a_course_name
			semester := a_semester
			exam_kind := a_exam_kind
			num_students := a_num_students
		ensure
			course_name.same_string (a_course_name)
			semester.same_string (a_semester)
			exam_kind.same_string (a_exam_kind)
			num_students.same_string (a_num_students)
		end

	course_name: STRING

	semester: STRING

	exam_kind: STRING

	num_students: STRING

end
