note
	description: "Summary description for {EXAM}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EXAM

create
	make

feature

	make (a_course_name: STRING; a_semester: STRING; a_exam_kind: STRING; a_num_students: STRING; a_id: INTEGER)
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
			id := a_id
		ensure
			course_name.same_string(a_course_name)
			semester.same_string(a_semester)
			exam_kind.same_string(a_exam_kind)
			num_students.same_string(a_num_students)
			id = a_id
		end

	id: INTEGER

	course_name: STRING

	semester: STRING

	exam_kind: STRING

	num_students: STRING

end
