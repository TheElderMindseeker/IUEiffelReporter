note
	description: "This class is additional class for creating template. It contains attributes only"
	author: "Niyaz Ginatullin"
	date: "10.04.2017"
	revision: "1.0"

class
	PATENT

create
	make

feature

	make (a_patent_title: STRING; a_patent_office_country: STRING)
		require
			a_patent_title /= Void
			a_patent_office_country /= Void
		do
			patent_title := a_patent_title
			patent_office_country := a_patent_office_country
		ensure
			patent_title.same_string (a_patent_title)
			patent_office_country.same_string (a_patent_office_country)
		end

	patent_title: STRING

	patent_office_country: STRING

end
