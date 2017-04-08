note
	description: "Summary description for {TEMPLATE_MORE_INFO}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TEMPLATE_MORE_INFO

inherit

	SHARED_TEMPLATE_CONTEXT

create
	make

feature

	output: detachable STRING

	make(a_id:INTEGER)

			-- Initialize `Current'.
		local
			p: PATH
		do
			create p.make_from_string ("www")
			p := p.appended ("/templates")
			set_template_folder (p)
			set_template_file_name ("view_detailed.tpl")
			create query_manager.make
			set_attributes
			id := a_id
			template.add_value (courses, "courses")
			template.add_value (examinations, "examinations")
			template.add_value (supervised_students, "supervised_students")
			template.add_value (student_reports, "student_reports")
			template.add_value (completed_phd, "completed_phd")
			template.add_value (grants, "grants")
			template.add_value (research_projects, "research_projects")
			template.add_value (research_collaborations, "research_collaborations")
			template.add_value (publications, "publications")
			template.analyze
			template.get_output
			if attached template.output as l_output then
				output := l_output
			end
		end

feature {NONE} -- ojects to create page

	set_attributes
		local
			info: LAB_FULL_INFO
		do
			create info.make (id)
			courses := info.get_courses
			examinations := info.get_examinations
			supervised_students := info.get_supervised_students
			student_reports := info.get_student_reports
			completed_phd := info.get_completed_phd
			grants := info.get_grants
			research_projects := info.get_research_projects
			research_collaborations := info.get_research_collaborations
			publications := info.get_publications
		end

	query_manager: QUERY_MANAGER

	id: INTEGER

	courses: LIST [COURSE]

	examinations: LIST [EXAM]

	supervised_students: LIST [STUDENT]

	student_reports: LIST [S_REPORT]

	completed_phd: LIST [PHD]

	grants: LIST [GRANT]

	research_projects: LIST [PROJECT]

	research_collaborations: LIST [COLLABORATION]

	publications: LIST [PUBLICATION]

feature {NONE}

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
