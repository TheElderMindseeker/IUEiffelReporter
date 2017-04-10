note
	description: "This class is additional class for creating template. It contains attributes only"
	author: "Niyaz Ginatullin"
	date: "10.04.2017"
	revision: "1.0"
	
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
