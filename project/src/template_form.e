note
	description: "Summary description for {HTML_TABLE_TEMPLATE}."
	author: ""
	date: "$Date: 2013-08-02 01:17:37 -0800 (Fri, 02 Aug 2013) $"
	revision: "$Revision: 92838 $"

class
	TEMPLATE_FORM

inherit

	SHARED_TEMPLATE_CONTEXT
		redefine
			default_create
		end

feature -- Initialization

	default_create
			-- Initialize `Current'.
		local
			p: PATH
		do
			create p.make_from_string ("www")
			p := p.appended ("/templates")
			set_template_folder (p)
			set_template_file_name ("form.tpl")
--			template.add_value (courses, "courses")
--			template.add_value (examinations, "examinations")
--			template.add_value (supervised_students, "supervised_students")
--			template.add_value (student_reports, "student_reports")
--			template.add_value (completed_phd, "completed_phd")
--			template.add_value (grants, "grants")
--			template.add_value (research_projects, "research_projects")
--			template.add_value (research_collaborations, "research_collaborations")
--			template.add_value (publications, "publications")
			template.analyze
			template.get_output
			if attached template.output as l_output then
				output := l_output
			end
		end

	output: detachable STRING

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
