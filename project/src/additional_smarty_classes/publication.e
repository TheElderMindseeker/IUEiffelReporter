note
	description: "This class is additional class for creating template. It contains attributes only"
	author: "Niyaz Ginatullin"
	date: "10.04.2017"
	revision: "1.0"
class
	PUBLICATION

create
	make

feature

	make (a_publication_name: STRING)
			-- creates report about some unit, that contains a lot general information abut this report
		require
			a_publication_name /= Void
		do
			publication_name := a_publication_name
		ensure
			publication_name.same_string(a_publication_name)
		end

	publication_name: STRING

end
