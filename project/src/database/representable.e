note
	description: "Summary description for {REPRESENTABLE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	REPRESENTABLE

feature -- Access

	repr: STRING_8
			-- SQLite representation of the object.
		deferred
		ensure
			result_exists: Result /= Void
			result_not_empty: Result.count > 0
		end

	usual_repr: STRING_8
			-- Usual string representation of the object.
		deferred
		ensure
			result_exists: Result /= Void
		end

end
