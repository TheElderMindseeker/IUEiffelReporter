note
	description: "Summary description for {WITHOUT_QUOTES}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	WITHOUT_QUOTES

feature
	without_quotes (str: STRING): STRING
		require
			str /= Void
		do
			if str.at (1).is_equal ('%'') and str.at (str.count).is_equal ('%'') then
				create Result.make_from_string (str.substring (2, str.count - 1))
			else
				create Result.make_from_string (str)
			end
		end

end
