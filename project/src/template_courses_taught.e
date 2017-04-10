note
	description: "Summary description for {TEXT_NUMBER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TEMPLATE_COURSES_TAUGHT

inherit
	WITHOUT_QUOTES

	SHARED_TEMPLATE_CONTEXT

create
	make

feature -- Initialization

	make (labname: STRING; a_courses: ITERABLE [ITERABLE [FIELD]])
			-- Reads text number template for admin page, it will be availible in get_output.
		local
			p: PATH
		do
			create courses.make
			create p.make_from_string ("www")
			p := p.appended ("/templates/query_responses")
			set_template_folder (p)
			set_template_file_name ("courses.tpl")
			set_courses(a_courses)
			template.add_value (labname, "labname")
			template.add_value (courses, "courses")
			template.analyze
			template.get_output
			if attached template.output as l_output then
				output := l_output
			end
		ensure then
			created_output: output /= Void
		end

	output: detachable STRING

feature {NONE} -- Implementation

	courses: LINKED_LIST [COURSE]

	set_courses(a_courses: ITERABLE [ITERABLE [FIELD]])
		local
			course_name: STRING
			semester: STRING
			edu_level: STRING
			num_students: STRING
		do
			across
				a_courses as course
			loop
				across
					course.item as field
				loop
					if field.item.name.same_string ("course_name") then
						course_name := without_quotes (field.item.value.repr)
					elseif field.item.name.same_string ("semester") then
						semester := without_quotes (field.item.value.repr)
					elseif field.item.name.same_string ("edu_level") then
						edu_level := without_quotes (field.item.value.repr)
					elseif field.item.name.same_string ("num_students") then
						num_students := field.item.value.repr
					end
				end
				if attached course_name as a_course_name and attached semester as a_semester and attached edu_level as a_edu_level and attached num_students as a_num_students then
					courses.force (create {COURSE}.make (a_course_name, a_semester, a_edu_level, a_num_students))
				end
			end
		end

	set_template_folder (v: PATH)
		do
			template_context.set_template_folder (v)
		end

	set_template_file_name (v: STRING)
		do
			create template.make_from_file (v)
		end

	set_template (v: like template)
		do
			template := v
		end

	template: TEMPLATE_FILE

end

