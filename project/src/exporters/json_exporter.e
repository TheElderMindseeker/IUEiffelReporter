note
	description: "JSON file format exporter class."
	author: "Daniil Botnarenku"
	date: "$Date$"
	revision: "$Revision$"

class
	JSON_EXPORTER

inherit
	EXPORTER
		redefine
			create_data_file
		end

feature -- Access

	create_data_file
			-- Create the data representation in wide-used format.
		local
			lab_info: LAB_FULL_INFO
		do
			create data_file.make_empty
			if attached data_file as string then
				create lab_info.make (report_id)
				string.append ("{%N%T%"report info%": {%N")
				if attached lab_info.get_report as report then
					string.append ("%T%T%T%"report id%": %"" + report.id.out + "%",%N")
					string.append ("%T%T%T%"unit name%": %"" + report.unit_name + "%",%N")
					string.append ("%T%T%T%"head name%": %"" + report.head_name + "%",%N")
					string.append ("%T%T%T%"report start%": %"" + report.rep_start + "%",%N")
					string.append ("%T%T%T%"report end%": %"" + report.rep_end + "%"%N")
				end
				string.append ("%T%T},%N")
				string.append ("%T%"courses%": [%N")
				if attached lab_info.get_courses as courses then
					from
						courses.start
					until
						courses.exhausted
					loop
						string.append ("%T%T{%N")
						string.append ("%T%T%T%"course name%": %"" + courses.item.course_name + "%",%N")
						string.append ("%T%T%T%"semester%": %"" + courses.item.semester + "%",%N")
						string.append ("%T%T%T%"educational level%": %"" + courses.item.edu_level + "%",%N")
						string.append ("%T%T%T%"number of students%": " + courses.item.num_students + "%N")
						courses.forth
						if not courses.exhausted then
							string.append ("%T%T},%N")
						else
							string.append ("%T%T}%N")
						end
					end
				end
				string.append ("%T],%N")
				string.append ("%T%"supervised students%": [%N")
				if attached lab_info.get_supervised_students as students then
					from
						students.start
					until
						students.exhausted
					loop
						string.append ("%T%T{%N")
						string.append ("%T%T%T%"student name%": %"" + students.item.student_name + "%",%N")
						string.append ("%T%T%T%"nature of work%": %"" + students.item.nature_of_work + "%"%N")
						students.forth
						if not students.exhausted then
							string.append ("%T%T},%N")
						else
							string.append ("%T%T}%N")
						end
					end
				end
				string.append ("%T],%N")
				string.append ("%T%"student reports%": [%N")
				if attached lab_info.get_student_reports as reports then
					from
						reports.start
					until
						reports.exhausted
					loop
						string.append ("%T%T{%N")
						string.append ("%T%T%T%"student name%": %"" + reports.item.student_name + "%",%N")
						string.append ("%T%T%T%"title%": %"" + reports.item.title + "%",%N")
						string.append ("%T%T%T%"publication plans%": %"" + reports.item.publication_plans + "%"%N")
						reports.forth
						if not reports.exhausted then
							string.append ("%T%T},%N")
						else
							string.append ("%T%T}%N")
						end
					end
				end
				string.append ("%T],%N")
				string.append ("%T%"completed phd%": [%N")
				if attached lab_info.get_completed_phd as phd then
					from
						phd.start
					until
						phd.exhausted
					loop
						string.append ("%T%T{%N")
						string.append ("%T%T%T%"student name%": %"" + phd.item.student_name + "%",%N")
						string.append ("%T%T%T%"degree%": %"" + phd.item.degree + "%",%N")
						string.append ("%T%T%T%"supervisor name%": %"" + phd.item.supervisor_name + "%",%N")
						string.append ("%T%T%T%"other committee members%": %"" + phd.item.other_committee_members + "%",%N")
						string.append ("%T%T%T%"degree granting installation%": %"" + phd.item.degree_granting_installation + "%",%N")
						string.append ("%T%T%T%"dissertation title%": " + phd.item.dissertation_title + "%N")
						phd.forth
						if not phd.exhausted then
							string.append ("%T%T},%N")
						else
							string.append ("%T%T}%N")
						end
					end
				end
				string.append ("%T],%N")
				string.append ("%T%"grants%": [%N")
				if attached lab_info.get_grants as grant then
					from
						grant.start
					until
						grant.exhausted
					loop
						string.append ("%T%T{%N")
						string.append ("%T%T%T%"project title%": %"" + grant.item.project_title + "%",%N")
						string.append ("%T%T%T%"granting agency%": %"" + grant.item.granting_agency + "%",%N")
						string.append ("%T%T%T%"start date%": %"" + grant.item.start_date + "%",%N")
						string.append ("%T%T%T%"end date%": %"" + grant.item.end_date + "%",%N")
						string.append ("%T%T%T%"is continuation%": %"" + grant.item.is_continuation + "%",%N")
						string.append ("%T%T%T%"amount%": " + grant.item.amount + "%N")
						grant.forth
						if not grant.exhausted then
							string.append ("%T%T},%N")
						else
							string.append ("%T%T}%N")
						end
					end
				end
				string.append ("%T],%N")
				string.append ("%T%"research projects%": [%N")
				if attached lab_info.get_research_projects as project then
					from
						project.start
					until
						project.exhausted
					loop
						string.append ("%T%T{%N")
						string.append ("%T%T%T%"project title%": %"" + project.item.project_title + "%",%N")
						string.append ("%T%T%T%"iu personnel involved%": %"" + project.item.iu_personnel_involved + "%",%N")
						string.append ("%T%T%T%"external personnel involved%": %"" + project.item.external_personnel_involved + "%",%N")
						string.append ("%T%T%T%"start date%": %"" + project.item.start_date + "%",%N")
						string.append ("%T%T%T%"expected end date%": %"" + project.item.expected_end_date + "%",%N")
						string.append ("%T%T%T%"financial sources%": %"" + project.item.financial_sources + "%"%N")
						project.forth
						if not project.exhausted then
							string.append ("%T%T},%N")
						else
							string.append ("%T%T}%N")
						end
					end
				end
				string.append ("%T],%N")
				string.append ("%T%"research collaborations%": [%N")
				if attached lab_info.get_research_collaborations as collaboration then
					from
						collaboration.start
					until
						collaboration.exhausted
					loop
						string.append ("%T%T{%N")
						string.append ("%T%T%T%"installation country%": %"" + collaboration.item.installation_country + "%",%N")
						string.append ("%T%T%T%"installation name%": %"" + collaboration.item.installation_name + "%",%N")
						string.append ("%T%T%T%"installation department%": %"" + collaboration.item.installation_department + "%",%N")
						string.append ("%T%T%T%"contacts%": %"" + collaboration.item.contacts + "%",%N")
						string.append ("%T%T%T%"nature of collaboration%": %"" + collaboration.item.nature_of_collaboration + "%"%N")
						collaboration.forth
						if not collaboration.exhausted then
							string.append ("%T%T},%N")
						else
							string.append ("%T%T}%N")
						end
					end
				end
				string.append ("%T],%N")
				string.append ("%T%"publications%": [%N")
				if attached lab_info.get_publications as publication then
					from
						publication.start
					until
						publication.exhausted
					loop
						string.append ("%T%T{%N")
						string.append ("%T%T%T%"publication name%": %"" + publication.item.publication_name + "%"%N")
						publication.forth
						if not publication.exhausted then
							string.append ("%T%T},%N")
						else
							string.append ("%T%T}%N")
						end
					end
				end
				string.append ("%T],%N")
				string.append ("%T%"examinations%": [%N")
				if attached lab_info.get_examinations as examination then
					from
						examination.start
					until
						examination.exhausted
					loop
						string.append ("%T%T{%N")
						string.append ("%T%T%T%"course name%": %"" + examination.item.course_name + "%",%N")
						string.append ("%T%T%T%"semester%": %"" + examination.item.semester + "%",%N")
						string.append ("%T%T%T%"examination kind%": %"" + examination.item.exam_kind + "%",%N")
						string.append ("%T%T%T%"number of students%": " + examination.item.num_students + "%N")
						examination.forth
						if not examination.exhausted then
							string.append ("%T%T},%N")
						else
							string.append ("%T%T}%N")
						end
					end
				end
				string.append ("%T],%N")
				string.append ("%T%"patents%": [%N")
				if attached lab_info.get_patents as patents then
					from
						patents.start
					until
						patents.exhausted
					loop
						string.append ("%T%T{%N")
						string.append ("%T%T%T%"patent title%": %"" + patents.item.patent_title + "%",%N")
						string.append ("%T%T%T%"patent office country%": %"" + patents.item.patent_office_country + "%"%N")
						patents.forth
						if not patents.exhausted then
							string.append ("%T%T},%N")
						else
							string.append ("%T%T}%N")
						end
					end
				end
				string.append ("%T],%N")
				string.append ("%T%"licenses%": [%N")
				if attached lab_info.get_licenses as licenses then
					from
						licenses.start
					until
						licenses.exhausted
					loop
						string.append ("%T%T{%N")
						string.append ("%T%T%T%"patent title%": %"" + licenses.item.patent_title + "%"%N")
						licenses.forth
						if not licenses.exhausted then
							string.append ("%T%T},%N")
						else
							string.append ("%T%T}%N")
						end
					end
				end
				string.append ("%T],%N")
				string.append ("%T%"best paper awards%": [%N")
				if attached lab_info.get_best_paper_awards as best_paper_awards then
					from
						best_paper_awards.start
					until
						best_paper_awards.exhausted
					loop
						string.append ("%T%T{%N")
						string.append ("%T%T%T%"authors%": %"" + best_paper_awards.item.authors + "%",%N")
						string.append ("%T%T%T%"title%": %"" + best_paper_awards.item.title + "%",%N")
						string.append ("%T%T%T%"awarding installation%": %"" + best_paper_awards.item.awarding_installation + "%",%N")
						string.append ("%T%T%T%"award exact wording%": %"" + best_paper_awards.item.award_exact_wording + "%",%N")
						string.append ("%T%T%T%"awarding date%": %"" + best_paper_awards.item.awarding_date + "%"%N")
						best_paper_awards.forth
						if not best_paper_awards.exhausted then
							string.append ("%T%T},%N")
						else
							string.append ("%T%T}%N")
						end
					end
				end
				string.append ("%T],%N")
				string.append ("%T%"memberships%": [%N")
				if attached lab_info.get_memberships as memberships then
					from
						memberships.start
					until
						memberships.exhausted
					loop
						string.append ("%T%T{%N")
						string.append ("%T%T%T%"member name%": %"" + memberships.item.member_name + "%",%N")
						string.append ("%T%T%T%"membership date%": %"" + memberships.item.membership_date + "%"%N")
						memberships.forth
						if not memberships.exhausted then
							string.append ("%T%T},%N")
						else
							string.append ("%T%T}%N")
						end
					end
				end
				string.append ("%T],%N")
				string.append ("%T%"prizes%": [%N")
				if attached lab_info.get_prizes as prizes then
					from
						prizes.start
					until
						prizes.exhausted
					loop
						string.append ("%T%T{%N")
						string.append ("%T%T%T%"recipient name%": %"" + prizes.item.recipient_name + "%",%N")
						string.append ("%T%T%T%"prize name%": %"" + prizes.item.prize_name + "%",%N")
						string.append ("%T%T%T%"prizing date%": %"" + prizes.item.prizing_date + "%"%N")
						prizes.forth
						if not prizes.exhausted then
							string.append ("%T%T},%N")
						else
							string.append ("%T%T}%N")
						end
					end
				end
				string.append ("%T],%N")
				string.append ("%T%"industry collaborations%": [%N")
				if attached lab_info.get_industry_collaborations as industry_collaborations then
					from
						industry_collaborations.start
					until
						industry_collaborations.exhausted
					loop
						string.append ("%T%T{%N")
						string.append ("%T%T%T%"company%": %"" + industry_collaborations.item.company + "%",%N")
						string.append ("%T%T%T%"nature of collaboration%": %"" + industry_collaborations.item.nature_of_collaboration + "%"%N")
						industry_collaborations.forth
						if not industry_collaborations.exhausted then
							string.append ("%T%T},%N")
						else
							string.append ("%T%T}%N")
						end
					end
				end
				string.append ("%T],%N")
				if attached lab_info.get_relevant_info as info then
					string.append ("%T%"relevant info%": %"" + info + "%"%N")
				end
				string.append ("}")
				lab_info.close_database
			end
		end

end
