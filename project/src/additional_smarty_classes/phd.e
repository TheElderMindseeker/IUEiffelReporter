note
	description: "This class is additional class for creating template. It contains attributes only"
	author: "Niyaz Ginatullin"
	date: "10.04.2017"
	revision: "1.0"

class
	PHD

create
	make

feature

	make (a_student_name: STRING; a_degree: STRING; a_supervisor_name: STRING; a_other_committee_members: STRING; a_degree_granting_installation: STRING; a_dissertation_title: STRING)
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
		ensure
			student_name.same_string (a_student_name)
			degree.same_string (a_degree)
			supervisor_name.same_string (a_supervisor_name)
			other_committee_members.same_string (a_other_committee_members)
			degree_granting_installation.same_string (a_degree_granting_installation)
			dissertation_title.same_string (a_dissertation_title)
		end

	student_name: STRING

	degree: STRING

	supervisor_name: STRING

	other_committee_members: STRING

	degree_granting_installation: STRING

	dissertation_title: STRING

end
