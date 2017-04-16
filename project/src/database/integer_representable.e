note
	description: "SQLite representable for integer type."
	author: "Daniil Botnarenku"
	date: "$Date$"
	revision: "$Revision$"

class
	INTEGER_REPRESENTABLE

inherit
	REPRESENTABLE

create
	make

feature {NONE} -- Initialization

	make (value: INTEGER)
			-- Initialization for `Current'.
		do
			integer_value := value
		ensure
			integer_value = value
		end

feature {NONE} -- Implementation

	integer_value: INTEGER
			-- Inner value of representable.

feature -- Access

	repr: STRING_8
			-- SQLite representation of the integer.
		do
			Result := integer_value.out
		end

	usual_repr:STRING
		-- Usual string representation of the object.
		do
			Result := integer_value.out
		end
end
