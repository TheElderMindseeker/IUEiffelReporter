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
				string.append ("%T%"research projects%": [%N")
				if attached lab_info.get_research_projects as project then
					from
						project.start
					until
						project.exhausted
					loop
						string.append ("%T%T{%N")
						string.append ("%T%T%T%"project title%": %"" + project.item.project_title + "%",%N")
						string.append ("%T%T%T%"iu personnel involved%" : %"" + project.item.iu_personnel_involved + "%",%N")
						string.append ("%T%T%T%"external personnel involved%" : %"" + project.item.external_personnel_involved + "%",%N")
						string.append ("%T%T%T%"start date%": %"" + project.item.start_date + "%",%N")
						string.append ("%T%T%T%"expected end date%": %"" + project.item.expected_end_date + "%",%N")
						string.append ("%T%T%T%"financial sources%" : %"" + project.item.financial_sources + "%"%N")
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
						string.append ("%T%T%T%"installation name%" : %"" + collaboration.item.installation_name + "%",%N")
						string.append ("%T%T%T%"installation department%" : %"" + collaboration.item.installation_department + "%",%N")
						string.append ("%T%T%T%"contacts%" : %"" + collaboration.item.contacts + "%",%N")
						string.append ("%T%T%T%"nature of collaboration%" : " + collaboration.item.nature_of_collaboration + "%N")
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
						string.append ("%T%T%T%"publication name%" : %"" + publication.item.publication_name + "%"%N")
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
						string.append ("%T%T%T%"course name%" : %"" + examination.item.course_name + "%",%N")
						string.append ("%T%T%T%"semester%" : %"" + examination.item.semester + "%",%N")
						string.append ("%T%T%T%"examination kind%" : %"" + examination.item.exam_kind + "%",%N")
						string.append ("%T%T%T%"number of students%" : " + examination.item.num_students + "%N")
						examination.forth
						if not examination.exhausted then
							string.append ("%T%T},%N")
						else
							string.append ("%T%T}%N")
						end
					end
				end
				string.append ("%T]%N")
				string.append ("}")
				lab_info.close_database
			end
		end

end
