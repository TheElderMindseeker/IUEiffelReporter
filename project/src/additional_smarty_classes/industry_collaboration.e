note
	description: "This class is additional class for creating template. It contains attributes only"
	author: "Niyaz Ginatullin"
	date: "10.04.2017"
	revision: "1.0"

class
	INDUSTRY_COLLABORATION

create
	make

feature

	make (a_company: STRING; a_nature_of_collaboration: STRING)
		require
			a_company /= Void
			a_nature_of_collaboration /= Void
		do
			company := a_company
			nature_of_collaboration := a_nature_of_collaboration
		ensure
			company.same_string (a_company)
			nature_of_collaboration.same_string (a_nature_of_collaboration)
		end

	company: STRING

	nature_of_collaboration: STRING

end
