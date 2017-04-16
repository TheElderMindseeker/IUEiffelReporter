note
	description: "Class representing sqlite-friendly string-type."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	STRING_REPRESENTABLE

inherit

	REPRESENTABLE
		redefine
			is_equal
		end

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

feature {STRING_REPRESENTABLE} -- Implemntation

	string_value: STRING_8
			-- Inner value of representable.

feature -- Access

	repr: STRING_8
			-- SQLite representation of the string.
		do
			Result := "'" + string_value + "'"
		end

	usual_repr: STRING_8
			-- Usual string representation of the object.
		do
			Result := string_value
		end

feature -- Comparison

	is_equal (other: like Current): BOOLEAN
			-- Is `Current' equal to `other'?
		do
			Result := string_value.same_string (other.string_value)
		end

end
