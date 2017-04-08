note
	description: "creates form page from /www/templates/form.tpl"
	author: ""
	date: "$Date: 2013-08-02 01:17:37 -0800 (Fri, 02 Aug 2013) $"
	revision: "$Revision: 92838 $"

class
	TEMPLATE_FORM

inherit

	SHARED_TEMPLATE_CONTEXT
		undefine
			default_create
		end

	ANY
		redefine
			default_create
		end

create
	default_create

feature {NONE} -- Initialization

	default_create

			-- Initialize `Current'.
		local
			p: PATH
		do
			create p.make_from_string ("www")
			p:=p.appended ("/templates")
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

feature -- Status
	get_output: detachable STRING
	do
		Result:=output
	end

	output: detachable STRING

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

--	courses : LIST[COURSE]
--		do
--			create {ARRAYED_LIST[COURSE]}Result.make(1)
--			Result.force(create {COURSE}.make ("", "", "", "", 0))
--		end

--	examinations : LIST[EXAM]
--		do
--			create {ARRAYED_LIST[EXAM]}Result.make(1)
--			Result.force(create {EXAM}.make ("", "", "", "", 0))
--		end

--	supervised_students : LIST[STUDENT]
--		do
--			create {ARRAYED_LIST[STUDENT]}Result.make(1)
--			Result.force(create {STUDENT}.make ("", "", 0))
--		end

--	student_reports : LIST[S_REPORT]
--		do
--			create {ARRAYED_LIST[S_REPORT]}Result.make(1)
--			Result.force(create {S_REPORT}.make ("", "", "", 0))
--		end

--	completed_phd : LIST[PHD]
--		do
--			create {ARRAYED_LIST[PHD]}Result.make(1)
--			Result.force(create {PHD}.make ("", "", "", "", "", "", 0))
--		end

--	grants : LIST[GRANT]
--		do
--			create {ARRAYED_LIST[GRANT]}Result.make(1)
--			Result.force(create {GRANT}.make ("", "", "", "", "", "", 0))
--		end

--	research_projects : LIST[PROJECT]
--		do
--			create {ARRAYED_LIST[PROJECT]}Result.make(1)
--			Result.force(create {PROJECT}.make ("", "", "", "", "", "", 0))
--		end

--	research_collaborations : LIST[COLLABORATION]
--		do
--			create {ARRAYED_LIST[COLLABORATION]}Result.make(1)
--			Result.force(create {COLLABORATION}.make ("", "", "", "", "", 0))
--		end

--	publications : LIST[PUBLICATION]
--		do
--			create {ARRAYED_LIST[PUBLICATION]}Result.make(1)
--			Result.force(create {PUBLICATION}.make ("", 0))
--		end
end
