note
	description: "Summary description for {PUBLICATION}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

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
