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
						string.append ("%T%T%T%"semester%" : %"" + courses.item.semester + "%",%N")
						string.append ("%T%T%T%"educational level%" : %"" + courses.item.edu_level + "%",%N")
						string.append ("%T%T%T%"number of students%" : " + courses.item.num_students + "%N")
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
						string.append ("%T%T%T%"nature of work%" : %"" + students.item.nature_of_work + "%"%N")
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
						string.append ("%T%T%T%"title%" : %"" + reports.item.title + "%",%N")
						string.append ("%T%T%T%"publication plans%" : %"" + reports.item.publication_plans + "%"%N")
						reports.forth
						if not reports.exhausted then
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
