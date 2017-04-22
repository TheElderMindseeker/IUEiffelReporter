note
	description: "This class is additional class for creating template. It contains attributes only"
	author: "Niyaz Ginatullin"
	date: "10.04.2017"
	revision: "1.0"

class
	LICENSE

create
	make

feature

	make (a_patent_title: STRING)
		require
			a_patent_title /= Void
		do
			patent_title := a_patent_title
		ensure
			patent_title.same_string (a_patent_title)
		end

	patent_title: STRING

end
