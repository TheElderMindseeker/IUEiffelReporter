note
	description: "Summary description for {FLOAT_REPRESENTABLE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	FLOAT_REPRESENTABLE

inherit
	REPRESENTABLE

create
	make

feature {NONE} -- Initialization

	make (value: REAL)
			-- Initialization for `Current'.
		do
			float_value := value
		end

feature {NONE} -- Implementation

	float_value: REAL
			-- Inner value of the representable

feature -- Access

	repr: STRING_8
			-- SQLite representation of the float.
		do
			Result := float_value.out
		end

end
