note
	description: "[
			This class returns LISTs of objects (additional smarty classes)
		 It's additional class to get data from database in needed form.
	]"
	author: "Niyaz Ginatullin"
	date: "10.04.2017"
	revision: "1.0"

class
	LAB_FULL_INFO

create
	make

feature

	make (a_id: INTEGER)
		do
			id := a_id
			create query_manager.make
		ensure
			id = a_id
		end

feature {NONE}

	id: INTEGER

	query_manager: QUERY_MANAGER

feature

	close_database
			-- Close database. This feature should be used after getting all info that is needed from this class.
		do
			query_manager.database_manager.close
		end

	get_courses: LIST [COURSE]
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
						course_name := field.item.value.usual_repr
					elseif field.item.name.same_string ("semester") then
						semester := field.item.value.usual_repr
					elseif field.item.name.same_string ("edu_level") then
						edu_level := field.item.value.usual_repr
					elseif field.item.name.same_string ("num_students") then
						num_students := field.item.value.repr
					end
				end
				if attached course_name as a_course_name and attached semester as a_semester and attached edu_level as a_edu_level and attached num_students as a_num_students then
					Result.force (create {COURSE}.make (a_course_name, a_semester, a_edu_level, a_num_students))
				end
			end
		end

	get_supervised_students: LIST [STUDENT]
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
						student_name := field.item.value.usual_repr
					elseif field.item.name.same_string ("nature_of_work") then
						nature_of_work := field.item.value.usual_repr
					end
				end
				if attached student_name as a_student_name and attached nature_of_work as a_nature_of_work then
					Result.force (create {STUDENT}.make (a_student_name, a_nature_of_work))
				end
			end
		end

	get_student_reports: LIST [S_REPORT]
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
						student_name := field.item.value.usual_repr
					elseif field.item.name.same_string ("title") then
						title := field.item.value.usual_repr
					elseif field.item.name.same_string ("publication_plans") then
						publication_plans := field.item.value.usual_repr
					end
				end
				if attached student_name as a_student_name and attached title as a_title and attached publication_plans as a_publication_plans then
					Result.force (create {S_REPORT}.make (a_student_name, a_title, a_publication_plans))
				end
			end
		end

	get_completed_phd: LIST [PHD]
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
						student_name := field.item.value.usual_repr
					elseif field.item.name.same_string ("degree") then
						degree := field.item.value.usual_repr
					elseif field.item.name.same_string ("supervisor_name") then
						supervisor_name := field.item.value.usual_repr
					elseif field.item.name.same_string ("other_committee_members") then
						other_committee_members := field.item.value.usual_repr
					elseif field.item.name.same_string ("degree_granting_installation") then
						degree_granting_installation := field.item.value.usual_repr
					elseif field.item.name.same_string ("dissertation_title") then
						dissertation_title := field.item.value.usual_repr
					end
				end
				if attached student_name as a_student_name and attached degree as a_degree and attached supervisor_name as a_supervisor_name and attached other_committee_members as a_other_committee_members and attached degree_granting_installation as a_degree_granting_installation and attached dissertation_title as a_dissertation_title then
					Result.force (create {PHD}.make (a_student_name, a_degree, a_supervisor_name, a_other_committee_members, a_degree_granting_installation, a_dissertation_title))
				end
			end
		end

	get_grants: LIST [GRANT]
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
				query_manager.database_manager.multiple_select ("grants", id) as list
			loop
				across
					list.item as field
				loop
					if field.item.name.same_string ("project_title") then
						project_title := field.item.value.usual_repr
					elseif field.item.name.same_string ("granting_agency") then
						granting_agency := field.item.value.usual_repr
					elseif field.item.name.same_string ("start_date") then
						start_date := field.item.value.usual_repr
					elseif field.item.name.same_string ("end_date") then
						end_date := field.item.value.usual_repr
					elseif field.item.name.same_string ("is_continuation") then
						is_continuation := field.item.value.usual_repr
					elseif field.item.name.same_string ("amount") then
						amount := field.item.value.repr
					end
				end
				if attached project_title as a_project_title and attached granting_agency as a_granting_agency and attached start_date as a_start_date and attached end_date as a_end_date and attached is_continuation as a_is_continuation and attached amount as a_amount then
					Result.force (create {GRANT}.make (a_project_title, a_granting_agency, a_start_date, a_end_date, a_is_continuation, a_amount))
				end
			end
		end

	get_research_projects: LIST [PROJECT]
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
				query_manager.database_manager.multiple_select ("research_projects", id) as list
			loop
				across
					list.item as field
				loop
					if field.item.name.same_string ("project_title") then
						project_title := field.item.value.usual_repr
					elseif field.item.name.same_string ("iu_personnel_involved") then
						iu_personnel_involved := field.item.value.usual_repr
					elseif field.item.name.same_string ("external_personnel_involved") then
						external_personnel_involved := field.item.value.usual_repr
					elseif field.item.name.same_string ("start_date") then
						start_date := field.item.value.usual_repr
					elseif field.item.name.same_string ("expected_end_date") then
						expected_end_date := field.item.value.usual_repr
					elseif field.item.name.same_string ("financial_sources") then
						financial_sources := field.item.value.usual_repr
					end
				end
				if attached project_title as a_project_title and attached iu_personnel_involved as a_iu_personnel_involved and attached external_personnel_involved as a_external_personnel_involved and attached start_date as a_start_date and attached expected_end_date as a_expected_end_date and attached financial_sources as a_financial_sources then
					Result.force (create {PROJECT}.make (a_project_title, a_iu_personnel_involved, a_external_personnel_involved, a_start_date, a_expected_end_date, a_financial_sources))
				end
			end
		end

	get_research_collaborations: LIST [COLLABORATION]
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
						installation_country := field.item.value.usual_repr
					elseif field.item.name.same_string ("installation_name") then
						installation_name := field.item.value.usual_repr
					elseif field.item.name.same_string ("installation_department") then
						installation_department := field.item.value.usual_repr
					elseif field.item.name.same_string ("contacts") then
						contacts := field.item.value.usual_repr
					elseif field.item.name.same_string ("nature_of_collaboration") then
						nature_of_collaboration := field.item.value.usual_repr
					end
				end
				if attached installation_country as a_installation_country and attached installation_name as a_installation_name and attached installation_department as a_installation_department and attached contacts as a_contacts and attached nature_of_collaboration as a_nature_of_collaboration then
					Result.force (create {COLLABORATION}.make (a_installation_country, a_installation_name, a_installation_department, a_contacts, a_nature_of_collaboration))
				end
			end
		end

	get_publications: LIST [PUBLICATION]
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
						publication_name := field.item.value.usual_repr
					end
				end
				if attached publication_name as a_publication_name then
					Result.force (create {PUBLICATION}.make (publication_name))
				end
			end
		end

	get_examinations: LIST [EXAM]
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
						course_name := field.item.value.usual_repr
					elseif field.item.name.same_string ("semester") then
						semester := field.item.value.usual_repr
					elseif field.item.name.same_string ("exam_kind") then
						exam_kind := field.item.value.usual_repr
					elseif field.item.name.same_string ("num_students") then
						num_students := field.item.value.repr
					end
				end
				if attached course_name as a_course_name and attached semester as a_semester and attached exam_kind as a_exam_kind and attached num_students as a_num_students then
					Result.force (create {EXAM}.make (a_course_name, a_semester, a_exam_kind, a_num_students))
				end
			end
		end

	get_relevant_info: STRING
		do
			create Result.make_from_string ("")
			across
				query_manager.database_manager.single_select ("relevant_info", id) as field
			loop
				if field.item.name.same_string ("info") then
					Result := field.item.value.usual_repr
				end
			end
		end

	get_report: REPORT
		local
			u_name: STRING
			h_name: STRING
			s_date: STRING
			e_date: STRING
			c_id: INTEGER
		do
			create u_name.make_from_string ("our default unit name")
			create h_name.make_from_string ("our default head name")
			create s_date.make_from_string ("01.09.2016")
			create e_date.make_from_string ("01.09.2017")
			across
				query_manager.database_manager.single_select ("reports", id) as field
			loop
				if field.item.name.same_string ("unit_name") then
					u_name := field.item.value.usual_repr
				elseif field.item.name.same_string ("head_name") then
					h_name := field.item.value.usual_repr
				elseif field.item.name.same_string ("rep_start") then
					s_date := field.item.value.usual_repr
				elseif field.item.name.same_string ("rep_end") then
					e_date := field.item.value.usual_repr
				elseif field.item.name.same_string ("report_id") then
					c_id := field.item.value.repr.to_integer
				end
			end
			create Result.make (u_name, h_name, s_date, e_date, id)
		end

	get_patents: LIST [PATENT]
		local
			patent_title: STRING
			patent_office_country: STRING
		do
			create {ARRAYED_LIST [PATENT]} Result.make (0)
			across
				query_manager.database_manager.multiple_select ("patents", id) as course
			loop
				across
					course.item as field
				loop
					if field.item.name.same_string ("patent_title") then
						patent_title := field.item.value.usual_repr
					elseif field.item.name.same_string ("patent_office_country") then
						patent_office_country := field.item.value.usual_repr
					end
				end
				if attached patent_title as pt and attached patent_office_country as poc then
					Result.force (create {PATENT}.make (pt, poc))
				end
			end
		end

	get_licenses: LIST [LICENSE]
		local
			patent_title: STRING
		do
			create {ARRAYED_LIST [LICENSE]} Result.make (0)
			across
				query_manager.database_manager.multiple_select ("licenses", id) as course
			loop
				across
					course.item as field
				loop
					if field.item.name.same_string ("patent_title") then
						patent_title := field.item.value.usual_repr
					end
				end
				if attached patent_title as pt then
					Result.force (create {LICENSE}.make (pt))
				end
			end
		end

	get_best_paper_awards: LIST [BEST_PAPER_AWARD]
		local
			authors: STRING
			title: STRING
			awarding_installation: STRING
			award_exact_wording: STRING
			awarding_date: STRING
		do
			create {ARRAYED_LIST [BEST_PAPER_AWARD]} Result.make (0)
			across
				query_manager.database_manager.multiple_select ("best_paper_awards", id) as course
			loop
				across
					course.item as field
				loop
					if field.item.name.same_string ("authors") then
						authors := field.item.value.usual_repr
					elseif field.item.name.same_string ("title") then
						title := field.item.value.usual_repr
					elseif field.item.name.same_string ("awarding_installation") then
						awarding_installation := field.item.value.usual_repr
					elseif field.item.name.same_string ("award_exact_wording") then
						award_exact_wording := field.item.value.usual_repr
					elseif field.item.name.same_string ("awarding_date") then
						awarding_date := field.item.value.usual_repr
					end
				end
				if attached authors as a and attached title as t and attached awarding_installation as aw and attached award_exact_wording as aew and attached awarding_date as ad then
					Result.force (create {BEST_PAPER_AWARD}.make (a, t, aw, aew, ad))
				end
			end
		end

	get_memberships: LIST [MEMBERSHIP]
		local
			member_name: STRING
			membership_date: STRING
		do
			create {ARRAYED_LIST [MEMBERSHIP]} Result.make (0)
			across
				query_manager.database_manager.multiple_select ("memberships", id) as course
			loop
				across
					course.item as field
				loop
					if field.item.name.same_string ("member_name") then
						member_name := field.item.value.usual_repr
					elseif field.item.name.same_string ("membership_date") then
						membership_date := field.item.value.usual_repr
					end
				end
				if attached member_name as mn and attached membership_date as md then
					Result.force (create {MEMBERSHIP}.make (mn, md))
				end
			end
		end

	get_prizes: LIST [PRIZE]
		local
			recipient_name: STRING
			prize_name: STRING
			prizing_date: STRING
		do
			create {ARRAYED_LIST [PRIZE]} Result.make (0)
			across
				query_manager.database_manager.multiple_select ("memberships", id) as course
			loop
				across
					course.item as field
				loop
					if field.item.name.same_string ("recipient_name") then
						recipient_name := field.item.value.usual_repr
					elseif field.item.name.same_string ("prize_name") then
						prize_name := field.item.value.usual_repr
					elseif field.item.name.same_string ("prizing_date") then
						prizing_date := field.item.value.usual_repr
					end
				end
				if attached recipient_name as rn and attached prize_name as pn and attached prizing_date as pd then
					Result.force (create {PRIZE}.make (rn, pn, pd))
				end
			end
		end

	get_industry_collaborations: LIST [INDUSTRY_COLLABORATION]
		local
			company: STRING
			nature_of_collaboration: STRING
		do
			create {ARRAYED_LIST [INDUSTRY_COLLABORATION]} Result.make (0)
			across
				query_manager.database_manager.multiple_select ("memberships", id) as course
			loop
				across
					course.item as field
				loop
					if field.item.name.same_string ("company") then
						company := field.item.value.usual_repr
					elseif field.item.name.same_string ("nature_of_collaboration") then
						nature_of_collaboration := field.item.value.usual_repr
					end
				end
				if attached company as c and attached nature_of_collaboration as noc then
					Result.force (create {INDUSTRY_COLLABORATION}.make (c, noc))
				end
			end
		end

end
