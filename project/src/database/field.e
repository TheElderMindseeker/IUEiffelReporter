note
	description: "Class maintaining database fields."
	author: "Daniil Botnarenku"
	date: "$Date$"
	revision: "$Revision$"

class
	FIELD

create
	make

feature {NONE} -- Initialization

	make (f_name: STRING_8; f_value: REPRESENTABLE)
			-- Initialization for `Current'.
		do
			name := f_name
			value := f_value
		end

feature -- Access

	name: STRING_8
			-- Field mnemonic `name'.

	value: REPRESENTABLE
			-- Field `value'.

end
