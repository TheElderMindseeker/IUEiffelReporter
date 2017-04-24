note
	description: "XML file format exporter class."
	author: "Daniil Botnarenku"
	date: "$Date$"
	revision: "$Revision$"

class
	XML_EXPORTER

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
				string.append ("<?xml version=%"1.0%" encoding=%"UTF-8%"?>%N")
				string.append ("<ReportInfo ")
				if attached lab_info.get_report as report then
					string.append ("report_id=%"" + report.id.out + "%"")
					string.append (" unit_name=%"" + report.unit_name + "%"")
					string.append (" head_name=%"" + report.head_name + "%"")
					string.append (" report_start=%"" + report.rep_start + "%"")
					string.append (" report_end=%"" + report.rep_end + "%"")
				end
				string.append (">%N")
				string.append ("%T<Courses>%N")
				if attached lab_info.get_courses as courses then
					from
						courses.start
					until
						courses.exhausted
					loop
						string.append ("%T%T<Course")
						string.append (" course_name=%"" + courses.item.course_name + "%"")
						string.append (" semester=%"" + courses.item.semester + "%"")
						string.append (" educational_level=%"" + courses.item.edu_level + "%"")
						string.append (" number_of_students=%"" + courses.item.num_students + "%"></Course>%N")
						courses.forth
					end
				end
				string.append ("%T</Courses>%N")
				string.append ("%T<SupervisedStudents>%N")
				if attached lab_info.get_supervised_students as students then
					from
						students.start
					until
						students.exhausted
					loop
						string.append ("%T%T<Student")
						string.append (" student_name=%"" + students.item.student_name + "%"")
						string.append (" nature_of_work=%"" + students.item.nature_of_work + "%"></Student>%N")
						students.forth
					end
				end
				string.append ("%T</SupervisedStudents>%N")
				string.append ("%T<StudentReports>%N")
				if attached lab_info.get_student_reports as reports then
					from
						reports.start
					until
						reports.exhausted
					loop
						string.append ("%T%T<StudentReport")
						string.append (" student_name=%"" + reports.item.student_name + "%"")
						string.append (" title=%"" + reports.item.title + "%"")
						string.append (" publication_plans=%"" + reports.item.publication_plans + "%"></StudentReport>%N")
						reports.forth
					end
				end
				string.append ("%T</StudentReports>%N")
				string.append ("%T<CompletedPhDs>%N")
				if attached lab_info.get_completed_phd as phd then
					from
						phd.start
					until
						phd.exhausted
					loop
						string.append ("%T%T<PhD")
						string.append (" student_name=%"" + phd.item.student_name + "%"")
						string.append (" degree=%"" + phd.item.degree + "%"")
						string.append (" supervisor name=%"" + phd.item.supervisor_name + "%"")
						string.append (" other committee members=%"" + phd.item.other_committee_members + "%"")
						string.append (" degree granting installation=%"" + phd.item.degree_granting_installation + "%"")
						string.append (" dissertation title=%"" + phd.item.dissertation_title + "%"></PhD>%N")
						phd.forth
					end
				end
				string.append ("%T</CompletedPhDs>%N")
				string.append ("%T<Grants>%N")
				if attached lab_info.get_grants as grant then
					from
						grant.start
					until
						grant.exhausted
					loop
						string.append ("%T%T<Grant")
						string.append (" project_title=%"" + grant.item.project_title + "%"")
						string.append (" granting_agency=%"" + grant.item.granting_agency + "%"")
						string.append (" start_date=%"" + grant.item.start_date + "%"")
						string.append (" end_date=%"" + grant.item.end_date + "%"")
						string.append (" is_continuation=%"" + grant.item.is_continuation + "%"")
						string.append (" amount=%"" + grant.item.amount + "%"></Grant>%N")
						grant.forth
					end
				end
				string.append ("%T</Grants>%N")
				string.append ("%T<ResearchProjects>%N")
				if attached lab_info.get_research_projects as project then
					from
						project.start
					until
						project.exhausted
					loop
						string.append ("%T%T<Project")
						string.append (" project_title=%"" + project.item.project_title + "%"")
						string.append (" iu_personnel_involved=%"" + project.item.iu_personnel_involved + "%"")
						string.append (" external_personnel_involved=%"" + project.item.external_personnel_involved + "%"")
						string.append (" start_date=%"" + project.item.start_date + "%"")
						string.append (" expected_end_date=%"" + project.item.expected_end_date + "%"")
						string.append (" financial_sources=%"" + project.item.financial_sources + "%"></Project>%N")
						project.forth
					end
				end
				string.append ("%T</ResearchProjects>%N")
				string.append ("%T<ResearchCollaborations>%N")
				if attached lab_info.get_research_collaborations as collaboration then
					from
						collaboration.start
					until
						collaboration.exhausted
					loop
						string.append ("%T%T<Collaboration")
						string.append (" installation_country=%"" + collaboration.item.installation_country + "%"")
						string.append (" installation_name=%"" + collaboration.item.installation_name + "%"")
						string.append (" installation_department=%"" + collaboration.item.installation_department + "%"")
						string.append (" contacts=%"" + collaboration.item.contacts + "%"")
						string.append (" nature_of_collaboration=%"" + collaboration.item.nature_of_collaboration + "%"></Collaboration>%N")
						collaboration.forth
					end
				end
				string.append ("%T</ResearchCollaborations>%N")
				string.append ("%T<Publications>%N")
				if attached lab_info.get_publications as publication then
					from
						publication.start
					until
						publication.exhausted
					loop
						string.append ("%T%T<Publication")
						string.append (" publication_name=%"" + publication.item.publication_name + "%"></Publication>%N")
						publication.forth
					end
				end
				string.append ("%T</Publications>%N")
				string.append ("%T<Examinations>%N")
				if attached lab_info.get_examinations as examination then
					from
						examination.start
					until
						examination.exhausted
					loop
						string.append ("%T%T<Examination")
						string.append (" course_name=%"" + examination.item.course_name + "%"")
						string.append (" semester=%"" + examination.item.semester + "%"")
						string.append (" examination_kind=%"" + examination.item.exam_kind + "%"")
						string.append (" number_of_students=%"" + examination.item.num_students + "%"></Examination>%N")
						examination.forth
					end
				end
				string.append ("%T</Examinations>%N")
				string.append ("%T<Patents>%N")
				if attached lab_info.get_patents as patents then
					from
						patents.start
					until
						patents.exhausted
					loop
						string.append ("%T%T<Patent")
						string.append (" patent_title=%"" + patents.item.patent_title + "%"")
						string.append (" patent_office_country=%"" + patents.item.patent_office_country + "%"></Patent>%N")
						patents.forth
					end
				end
				string.append ("%T</Patents>%N")
				string.append ("%T<Licenses>%N")
				if attached lab_info.get_licenses as licenses then
					from
						licenses.start
					until
						licenses.exhausted
					loop
						string.append ("%T%T<License")
						string.append (" patent_title=%"" + licenses.item.patent_title + "%"></License>%N")
						licenses.forth
					end
				end
				string.append ("%T</Licenses>%N")
				string.append ("%T<BestPaperAwards>%N")
				if attached lab_info.get_best_paper_awards as best_paper_awards then
					from
						best_paper_awards.start
					until
						best_paper_awards.exhausted
					loop
						string.append ("%T%T<Award")
						string.append (" authors=%"" + best_paper_awards.item.authors + "%"")
						string.append (" title=%"" + best_paper_awards.item.title + "%"")
						string.append (" awarding_installation=%"" + best_paper_awards.item.awarding_installation + "%"")
						string.append (" award_exact_wording=%"" + best_paper_awards.item.award_exact_wording + "%"")
						string.append (" awarding_date=%"" + best_paper_awards.item.awarding_date + "%"></Award>%N")
						best_paper_awards.forth
					end
				end
				string.append ("%T</BestPaperAwards>%N")
				string.append ("%T<Patents>%N")
				if attached lab_info.get_memberships as memberships then
					from
						memberships.start
					until
						memberships.exhausted
					loop
						string.append ("%T%T<Membership")
						string.append (" member_name=%"" + memberships.item.member_name + "%"")
						string.append (" membership_date=%"" + memberships.item.membership_date + "%"></Membership>%N")
						memberships.forth
					end
				end
				string.append ("%T</Patents>%N")
				string.append ("%T<Prizes>%N")
				if attached lab_info.get_prizes as prizes then
					from
						prizes.start
					until
						prizes.exhausted
					loop
						string.append ("%T%T<Prize")
						string.append (" recipient_name=%"" + prizes.item.recipient_name + "%"")
						string.append (" prize _name=%"" + prizes.item.prize_name + "%"")
						string.append (" prizing_date=%"" + prizes.item.prizing_date + "%"></Prize>%N")
						prizes.forth
					end
				end
				string.append ("%T</Prizes>%N")
				string.append ("%T<IndustryCollaborations>%N")
				if attached lab_info.get_industry_collaborations as industry_collaborations then
					from
						industry_collaborations.start
					until
						industry_collaborations.exhausted
					loop
						string.append ("%T%T<Collaboration")
						string.append (" company=%"" + industry_collaborations.item.company + "%"")
						string.append (" nature_of_collaboration=%"" + industry_collaborations.item.nature_of_collaboration + "%"></Collaboration>%N")
						industry_collaborations.forth
					end
				end
				string.append ("%T</IndustryCollaborations>%N")
				if attached lab_info.get_relevant_info as info then
					string.append ("%T<RelevantInfo relevant_info=%"" + info + "%"></RelevantInfo>%N")
				end
				string.append ("</ReportInfo>")
				lab_info.close_database
			end
		end

end
