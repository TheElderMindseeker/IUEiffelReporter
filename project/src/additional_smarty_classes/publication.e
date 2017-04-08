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

	make (text: STRING; a_id: INTEGER)
			-- creates report about some unit, that contains a lot general information abut this report
		require
			text /= Void
		do
			id := a_id
			publication_name := text
		ensure
			id = a_id
			publication_name.same_string(text)
		end

	publication_name: STRING

	id: INTEGER

end
