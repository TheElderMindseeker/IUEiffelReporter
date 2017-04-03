note
	description: "Summary description for {USER}."
	author: ""
	date: "$Date: 2013-08-02 01:17:37 -0800 (Fri, 02 Aug 2013) $"
	revision: "$Revision: 92838 $"

class
	USER
create
	make
feature {NONE} -- Initialization
	make (a_name : STRING; a_phone: STRING)
		do
			name := a_name
			phone := a_phone
		end

feature -- Access

	name : STRING
	phone : STRING

end
