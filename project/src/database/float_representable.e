note
	description: "Class representing sqlite-friendly float-type."
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
			Result := float_value.to_double.out
		end

	usual_repr: STRING
			-- Usual string representation of the object
		do
			Result := float_value.to_double.out
		end

end
