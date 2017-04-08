note
	description: "Summary description for {PHD}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	PHD

create
	make

feature

	make (a_student_name: STRING; a_degree: STRING; a_supervisor_name: STRING; a_other_committee_members: STRING; a_degree_granting_installation: STRING; a_dissertation_title: STRING; a_id: INTEGER)
			-- creates report about some unit, that contains a lot general information abut this report
		require
			a_student_name /= Void
			a_degree /= Void
			a_supervisor_name /= Void
			a_other_committee_members /= Void
			a_degree_granting_installation /= Void
		do
			student_name := a_student_name
			degree := a_degree
			supervisor_name := a_supervisor_name
			other_committee_members := a_other_committee_members
			degree_granting_installation := a_degree_granting_installation
			dissertation_title := a_dissertation_title
			id := a_id
		ensure
			student_name.same_string(a_student_name)
			degree.same_string(a_degree)
			supervisor_name.same_string (a_supervisor_name)
			other_committee_members.same_string(a_other_committee_members)
			degree_granting_installation.same_string(a_degree_granting_installation)
			dissertation_title.same_string(a_dissertation_title)
			id = a_id
		end

	id: INTEGER

	student_name: STRING

	degree: STRING

	supervisor_name: STRING

	other_committee_members: STRING

	degree_granting_installation: STRING

	dissertation_title: STRING

end
