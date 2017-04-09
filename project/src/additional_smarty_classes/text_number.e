note
	description: "Summary description for {TEXT_STRING}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TEXT_NUMBER
create
	make

feature

	make (a_text: STRING; a_number: INTEGER)
			-- creates report about some unit, that contains a lot general information abut this report
		require
			a_text /= Void
		do
			text := a_text
			number := a_number
		ensure
			number = a_number
			text.same_string(a_text)
		end

	text: STRING

	number: INTEGER

end
