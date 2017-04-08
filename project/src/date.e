note
	description: "Class representing sqlite-friendly date-type."
	author: "Daniil Botnarenku"
	date: "$Date$"
	revision: "$Revision$"

class
	DATE

inherit

	COMPARABLE
		redefine
			is_equal,
			out
		end

	REPRESENTABLE
		undefine
			is_equal,
			out
		end

create
	make,
	make_from_string,
	make_from_iso_string

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

	make_from_string (date_string: READABLE_STRING_32)
			-- Make date from standard string representation
		require
			string_exists_and_not_empty: date_string /= Void and date_string.count > 0
			all_components_present: date_string.split ('.').count >= 3
			valid_date: True -- TODO: formulate strict contract here
		local
			components: LIST [READABLE_STRING_32]
		do
			components := date_string.split ('.')
			day := components.i_th (1).to_integer_32
			month := components.i_th (2).to_integer_32
			year := components.i_th (3).to_integer_32
		ensure
			right_assignment: True -- TODO: Formulate strict contract here
		end

	make_from_iso_string (iso_string: READABLE_STRING_32)
			-- Make date from ISO date string
		require
			string_exists_and_not_empty: iso_string /= Void and iso_string.count > 0
			all_components_present: iso_string.split ('-').count >= 3
			valid_date: True -- TODO: formulate strict contract here
		local
			components: LIST [READABLE_STRING_32]
		do
			components := iso_string.split ('-')
			year := components.i_th (1).to_integer_32
			month := components.i_th (2).to_integer_32
			day := components.i_th (3).to_integer_32
		ensure
			right_assignment: True -- TODO: Formulate strict contract here
		end

feature {DATE} -- Attributes

	year: INTEGER_32
			-- Year in the date

	month: INTEGER_32
			-- Month in the date

	day: INTEGER_32
			-- Day in the date

feature -- Comparison

	is_equal (other: like Current): BOOLEAN
			-- Is `other' attached to an object considered
			-- equal to current object?
		do
			Result := year = other.year and month = other.month and day = other.day
		end

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
		end

	repr: STRING_8
			-- SQLite representation of the object.
		do
			Result := "'" + out + "'"
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
