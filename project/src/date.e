note
	description: "Class representing sqlite-friendly date-type."
	author: "Daniil Botnarenku"
	date: "$Date$"
	revision: "$Revision$"

class
	DATE

inherit
	ANY
		redefine
			out
		end

	COMPARABLE
		redefine
			is_less
		end

create
	make,
	make_from_string

feature {NONE} -- Initialization

	make (yy, mm, dd: INTEGER)
			-- Make date from three integer elements representing `year', `month' and `day'
		require
			valid_date: valid_date (yy, mm, dd)
		do
			year := yy
			month := mm
			day := dd
		ensure
			year = yy
			month = mm
			day = dd
		end

feature {DATE} -- Attributes

	year: INTEGER
			-- Year in the date

	month: INTEGER
			-- Month in the date

	day: INTEGER
			-- Day in the date

feature -- Comparison

	is_less alias "<" (other: like Current): BOOLEAN
			-- Is current object less than `other'?
		do
			Result := False
			if year < other.year then
				Result := True
			elseif month < other.month then
				Result := True
			elseif day < other.day then
				Result := True
			end
		end

feature -- String representation

	out: STRING
			-- New string containing terse printable representation
			-- of current object
		do
			Result := year.out + "-" + month.out + "-" + day.out
		ensure
			result_exists_and_not_empty: Result /= Void and then Result.count > 0
		end

feature -- Constraints

	valid_date (yy, mm, dd: INTEGER): BOOLEAN
			-- Is provided date valid?
		local
			month_30: ARRAY[INTEGER]
		do
			month_30 := <<4, 6, 9, 11>>
			Result := True
			if yy <= 0 then
				Result := False
			end
			if mm < 1 or mm > 12 then
				Result := False
			end
			if dd < 1 or dd > 31 then
				Result := False
			else
				if month_30.has (mm) then
					if dd > 30 then
						Result := False
					end
				elseif mm = 2 then
					if yy \\ 4 = 0 then
						if dd > 29 then
							Result := False
						end
					else
						if dd > 28 then
							Result := False
						end
					end
				end
			end
		end

invariant
	valid_date: valid_date (year, month, day)

end
