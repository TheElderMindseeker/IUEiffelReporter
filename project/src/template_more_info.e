note
	description: "Summary description for {TEMPLATE_MORE_INFO}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TEMPLATE_MORE_INFO

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

feature

	output: detachable STRING

	default_create

			-- Initialize `Current'.
		local
			p: PATH
		do
			create p.make_from_string ("www")
			p := p.appended ("/templates")
			set_template_folder (p)
			set_template_file_name ("view_detailed.tpl")
			create query_manager.make
		end

	generate_page_with_id (a_id: INTEGER)
		do
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

	query_manager: QUERY_MANAGER

	id: INTEGER

	courses: LIST [COURSE]
		local
			course_name: STRING
			semester: STRING
			edu_level: STRING
			num_students: STRING
		do
			create {ARRAYED_LIST [COURSE]} Result.make (0)
			across
				query_manager.database_manager.multiple_select ("courses", id) as course
			loop
				across
					course.item as field
				loop
					if field.item.name.same_string ("course_name") then
						course_name := field.item.value.repr
					elseif field.item.name.same_string ("semester") then
						semester := field.item.value.repr
					elseif field.item.name.same_string ("edu_level") then
						edu_level := field.item.value.repr
					elseif field.item.name.same_string ("num_students") then
						num_students := field.item.value.repr
					end
				end
				if attached course_name as a_course_name and attached semester as a_semester and attached edu_level as a_edu_level and attached num_students as a_num_students then
					Result.force (create {COURSE}.make (a_course_name, a_semester, a_edu_level, a_num_students, id))
				end
			end
		end

	examinations: LIST [EXAM]
		local
			course_name: STRING
			semester: STRING
			exam_kind: STRING
			num_students: STRING
		do
			create {ARRAYED_LIST [EXAM]} Result.make (0)
			across
				query_manager.database_manager.multiple_select ("examinations", id) as list
			loop
				across
					list.item as field
				loop
					if field.item.name.same_string ("course_name") then
						course_name := field.item.value.repr
					elseif field.item.name.same_string ("semester") then
						semester := field.item.value.repr
					elseif field.item.name.same_string ("exam_kind") then
						exam_kind := field.item.value.repr
					elseif field.item.name.same_string ("num_students") then
						num_students := field.item.value.repr
					end
				end
				if attached course_name as a_course_name and attached semester as a_semester and attached exam_kind as a_exam_kind and attached num_students as a_num_students then
					Result.force (create {EXAM}.make (a_course_name, a_semester, a_exam_kind, a_num_students, id))
				end
			end
		end

	supervised_students: LIST [STUDENT]
		local
			student_name: STRING
			nature_of_work: STRING
		do
			create {ARRAYED_LIST [STUDENT]} Result.make (1)
			across
				query_manager.database_manager.multiple_select ("supervised_students", id) as list
			loop
				across
					list.item as field
				loop
					if field.item.name.same_string ("student_name") then
						student_name := field.item.value.repr
					elseif field.item.name.same_string ("nature_of_work") then
						nature_of_work := field.item.value.repr
					end
				end
				if attached student_name as a_student_name and attached nature_of_work as a_nature_of_work then
					Result.force (create {STUDENT}.make (a_student_name, a_nature_of_work, id))
				end
			end
		end

	student_reports: LIST [S_REPORT]
		local
			student_name: STRING
			title: STRING
			publication_plans: STRING
		do
			create {ARRAYED_LIST [S_REPORT]} Result.make (0)
			across
				query_manager.database_manager.multiple_select ("student_reports", id) as list
			loop
				across
					list.item as field
				loop
					if field.item.name.same_string ("student_name") then
						student_name := field.item.value.repr
					elseif field.item.name.same_string ("title") then
						title := field.item.value.repr
					elseif field.item.name.same_string ("publication_plans") then
						publication_plans := field.item.value.repr
					end
				end
				if attached student_name as a_student_name and attached title as a_title and attached publication_plans as a_publication_plans then
					Result.force (create {S_REPORT}.make (a_student_name, a_title, a_publication_plans, id))
				end
			end
		end

	completed_phd: LIST [PHD]
		local
			student_name: STRING
			degree: STRING
			supervisor_name: STRING
			other_committee_members: STRING
			degree_granting_installation: STRING
			dissertation_title: STRING
		do
			create {ARRAYED_LIST [PHD]} Result.make (1)
			across
				query_manager.database_manager.multiple_select ("completed_phd", id) as list
			loop
				across
					list.item as field
				loop
					if field.item.name.same_string ("student_name") then
						student_name := field.item.value.repr
					elseif field.item.name.same_string ("degree") then
						degree := field.item.value.repr
					elseif field.item.name.same_string ("supervisor_name") then
						supervisor_name := field.item.value.repr
					elseif field.item.name.same_string ("other_committee_members") then
						other_committee_members := field.item.value.repr
					elseif field.item.name.same_string ("degree_granting_installation") then
						degree_granting_installation := field.item.value.repr
					elseif field.item.name.same_string ("dissertation_title") then
						dissertation_title := field.item.value.repr
					end
				end
				if attached student_name as a_student_name and attached degree as a_degree and attached supervisor_name as a_supervisor_name and attached other_committee_members as a_other_committee_members and attached degree_granting_installation as a_degree_granting_installation and attached dissertation_title as a_dissertation_title then
					Result.force (create {PHD}.make (a_student_name, a_degree, a_supervisor_name, a_other_committee_members, a_degree_granting_installation, a_dissertation_title, id))
				end
			end
		end

	grants: LIST [GRANT]
		local
			project_title: STRING
			granting_agency: STRING
			start_date: STRING
			end_date: STRING
			is_continuation: STRING
			amount: STRING
		do
			create {ARRAYED_LIST [GRANT]} Result.make (0)
			across
				query_manager.database_manager.multiple_select ("completed_phd", id) as list
			loop
				across
					list.item as field
				loop
					if field.item.name.same_string ("project_title") then
						project_title := field.item.value.repr
					elseif field.item.name.same_string ("granting_agency") then
						granting_agency := field.item.value.repr
					elseif field.item.name.same_string ("start_date") then
						start_date := field.item.value.repr
					elseif field.item.name.same_string ("end_date") then
						end_date := field.item.value.repr
					elseif field.item.name.same_string ("is_continuation") then
						is_continuation := field.item.value.repr
					elseif field.item.name.same_string ("amount") then
						amount := field.item.value.repr
					end
				end
				if attached project_title as a_project_title and attached granting_agency as a_granting_agency and attached start_date as a_start_date and attached end_date as a_end_date and attached is_continuation as a_is_continuation and attached amount as a_amount then
					Result.force (create {GRANT}.make (a_project_title, a_granting_agency, a_start_date, a_end_date, a_is_continuation, a_amount, id))
				end
			end
		end

	research_projects: LIST [PROJECT]
		local
			project_title: STRING
			iu_personnel_involved: STRING
			external_personnel_involved: STRING
			start_date: STRING
			expected_end_date: STRING
			financial_sources: STRING
		do
			create {ARRAYED_LIST [PROJECT]} Result.make (0)
			across
				query_manager.database_manager.multiple_select ("completed_phd", id) as list
			loop
				across
					list.item as field
				loop
					if field.item.name.same_string ("project_title") then
						project_title := field.item.value.repr
					elseif field.item.name.same_string ("iu_personnel_involved") then
						iu_personnel_involved := field.item.value.repr
					elseif field.item.name.same_string ("external_personnel_involved") then
						external_personnel_involved := field.item.value.repr
					elseif field.item.name.same_string ("start_date") then
						start_date := field.item.value.repr
					elseif field.item.name.same_string ("expected_end_date") then
						expected_end_date := field.item.value.repr
					elseif field.item.name.same_string ("financial_sources") then
						financial_sources := field.item.value.repr
					end
				end
				if attached project_title as a_project_title and attached iu_personnel_involved as a_iu_personnel_involved and attached external_personnel_involved as a_external_personnel_involved and attached start_date as a_start_date and attached expected_end_date as a_expected_end_date and attached financial_sources as a_financial_sources then
					Result.force (create {PROJECT}.make (a_project_title, a_iu_personnel_involved, a_external_personnel_involved, a_start_date, a_expected_end_date, a_financial_sources, id))
				end
			end
		end

	research_collaborations: LIST [COLLABORATION]
		local
			installation_country: STRING
			installation_name: STRING
			installation_department: STRING
			contacts: STRING
			nature_of_collaboration: STRING
		do
			create {ARRAYED_LIST [COLLABORATION]} Result.make (0)
			across
				query_manager.database_manager.multiple_select ("research_collaborations", id) as list
			loop
				across
					list.item as field
				loop
					if field.item.name.same_string ("installation_country") then
						installation_country := field.item.value.repr
					elseif field.item.name.same_string ("installation_name") then
						installation_name := field.item.value.repr
					elseif field.item.name.same_string ("installation_department") then
						installation_department := field.item.value.repr
					elseif field.item.name.same_string ("contacts") then
						contacts := field.item.value.repr
					elseif field.item.name.same_string ("nature_of_collaboration") then
						nature_of_collaboration := field.item.value.repr
					end
				end
				if attached installation_country as a_installation_country and attached installation_name as a_installation_name and attached installation_department as a_installation_department and attached contacts as a_contacts and attached nature_of_collaboration as a_nature_of_collaboration then
					Result.force (create {COLLABORATION}.make (a_installation_country, a_installation_name, a_installation_department, a_contacts, a_nature_of_collaboration, id))
				end
			end
		end

	publications: LIST [PUBLICATION]
		local
			publication_name: STRING
		do
			create {ARRAYED_LIST [PUBLICATION]} Result.make (1)
			across
				query_manager.database_manager.multiple_select ("publications", id) as list
			loop
				across
					list.item as field
				loop
					if field.item.name.same_string ("publication_name") then
						publication_name := field.item.value.repr
					end
				end
				if attached publication_name as a_publication_name then
					Result.force (create {PUBLICATION}.make (publication_name, id))
				end
			end
		end

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
