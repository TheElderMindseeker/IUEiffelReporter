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

	make (a_publication_name: STRING; a_id: INTEGER)
			-- creates report about some unit, that contains a lot general information abut this report
		require
			a_publication_name /= Void
		do
			id := a_id
			publication_name := a_publication_name
		ensure
			id = a_id
			publication_name.same_string(a_publication_name)
		end

	publication_name: STRING

	id: INTEGER

end
