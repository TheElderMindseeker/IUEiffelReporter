note
	description: "Template for detailed view of some report"
	author: "Ginatullin Niyaz"
	date: "10.04.2017"
	revision: "1.0"

class
	TEMPLATE_MORE_INFO

inherit

	SHARED_TEMPLATE_CONTEXT

create
	make

feature

	id: INTEGER
			-- Id of report.

	output: detachable STRING
			-- Output of template.

	make (a_id: INTEGER)

			-- Initialize `Current'.
		local
			p: PATH
		do
			create p.make_from_string ("www")
			p := p.appended ("/templates")
			set_template_folder (p)
			set_template_file_name ("view_detailed.tpl")
			add_all_values (a_id)
			template.analyze
			template.get_output
			if attached template.output as l_output then
				output := l_output
			end
		end

feature {NONE} -- Implementation

	add_all_values (a_id: INTEGER)
			-- Fills template.
		do
			set_all_attributes (a_id)
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
			template.add_value (memberships, "memberships")
			template.add_value (prizes, "prizes")
			template.add_value (industry_collaborations, "industry_collaborations")
			template.add_value (relevant_info, "relevant_info")
		end

	set_all_attributes (a_id: INTEGER)
			-- Fills lists of nedeed information.
		local
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
			memberships := info.get_memberships
			prizes := info.get_prizes
			industry_collaborations := info.get_industry_collaborations
			relevant_info := info.get_relevant_info
			info.close_database
		end

	report: REPORT
			-- Report main info

	relevant_info: STRING
			-- relevant info

	memberships: LIST [MEMBERSHIP]
			--List of memberships

	prizes: LIST [PRIZE]
			--List of prizes

	industry_collaborations: LIST [INDUSTRY_COLLABORATION]
			--List of industry collaborations

	courses: LIST [COURSE]
			-- List of courses

	examinations: LIST [EXAM]
			-- List of examinations

	supervised_students: LIST [STUDENT]
			-- List of supervised students

	student_reports: LIST [S_REPORT]
			-- List of studen reports

	completed_phd: LIST [PHD]
			-- List of completed phds

	grants: LIST [GRANT]
			-- List of grants

	research_projects: LIST [PROJECT]
			-- List of research projects

	research_collaborations: LIST [COLLABORATION]
			-- List of research collaborations

	publications: LIST [PUBLICATION]
			-- List of publications

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
