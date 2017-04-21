note
	description: "Template for /form"
	author: "Ginatullin Niyaz"
	date: "10.04.2017"
	revision: "1.0"

class
	TEMPLATE_FORM

inherit

	SHARED_TEMPLATE_CONTEXT

create
	make

feature -- Initialization

	make (id: INTEGER)
			-- Initialize `Current'.
		local
			p: PATH
		do
			create p.make_from_string ("www")
			p := p.appended ("/templates")
			set_template_folder (p)
			set_template_file_name ("form.tpl")
			if id > 0 then
				add_all_values (id)
			end
			template.add_value (id, "id")
			template.analyze
			template.get_output
			if attached template.output as l_output then
				output := l_output
			end
		end
feature --Access
	output: detachable STRING

feature {NONE} -- Implementation

	add_all_values (a_id: INTEGER)
			-- Fills template.
		local
			report: REPORT -- Report main info

			courses: LIST [COURSE] -- List of courses

			examinations: LIST [EXAM] -- List of examinations

			supervised_students: LIST [STUDENT] -- List of supervised students

			student_reports: LIST [S_REPORT] -- List of studen reports

			completed_phd: LIST [PHD] -- List of completed phds

			grants: LIST [GRANT] -- List of grants

			research_projects: LIST [PROJECT] -- List of research projects

			research_collaborations: LIST [COLLABORATION] -- List of research collaborations

			publications: LIST [PUBLICATION] -- List of publications
			info: LAB_FULL_INFO
		do
			create info.make (a_id)
			report := info.get_report
			courses := info.get_courses
			examinations := info.get_examinations
			supervised_students := info.get_supervised_students
			student_reports := info.get_student_reports
			completed_phd := info.get_completed_phd
			grants := info.get_grants
			research_projects := info.get_research_projects
			research_collaborations := info.get_research_collaborations
			publications := info.get_publications
			info.close_database
			template.add_value (report.unit_name, "unit_name")
			template.add_value (report.head_name, "head_name")
			template.add_value (report.rep_start, "rep_start")
			template.add_value (report.rep_end, "rep_end")
			template.add_value (courses, "courses")
			template.add_value (examinations, "examinations")
			template.add_value (supervised_students, "supervised_students")
			template.add_value (student_reports, "student_reports")
			template.add_value (completed_phd, "completed_phd")
			template.add_value (grants, "grants")
			template.add_value (research_projects, "research_projects")
			template.add_value (research_collaborations, "research_collaborations")
			template.add_value (publications, "publications")
		end

feature {NONE} -- Implementation

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
