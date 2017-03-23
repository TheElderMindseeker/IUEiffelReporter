note
	description: "Summary description for {STRING_REPRESENTABLE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	STRING_REPRESENTABLE

inherit
	REPRESENTABLE

create
	make

feature {NONE} -- Initialization

	make (value: STRING_8)
			-- Initialization for `Current'.
		require
			value /= Void
		do
			string_value := value
		ensure
			string_value = value
		end

feature {NONE} -- Implemntation

	string_value: STRING_8
			-- Inner value of representable.

feature -- Access

	repr: STRING_8
			-- SQLite representation of the string.
		do
			Result := "'" + string_value + "'"
		end

end
