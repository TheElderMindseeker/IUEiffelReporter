note
	description: "Summary description for {ADMIN_PAGE_PARSER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ADMIN_PAGE_PARSER

create
	make

feature {NONE} -- Initialization

	make (j_str: STRING)
			-- Initialize `Current'.
		require
			json_exists: j_str /= Void
		do
			source_json := j_str
		ensure
			successful_json_assignment: source_json = j_str
		end

	source_json: STRING
			-- The json string to be parsed.

feature --Attributes

	start_date: detachable DATE
		--start date of query

	end_date: detachable DATE
		--end date of query

	type_of_query: detachable STRING
		--type of query

	lab_name: detachable STRING
		-- name of laboratory

feature -- Parsing

	parse
			--parses content and fills attributes
		local
			parser: JSON_PARSER
		do
			create parser.make_with_string (source_json)
			parser.parse_content
			if parser.is_parsed and then parser.is_valid and then attached parser.parsed_json_value as jv then
				if attached {JSON_OBJECT} jv as j_object then
					if attached {JSON_STRING} j_object.item ("lab_name") as a then
						create lab_name.make_from_string (a.item)
					end
					if attached {JSON_STRING} j_object.item ("type_of_query") as a then
						create type_of_query.make_from_string (a.item)
					end
					if attached {JSON_STRING} j_object.item ("end_date") as a then
						create end_date.make_from_string (a.item)
					end
					if attached {JSON_STRING} j_object.item ("start_date") as a then
						create start_date.make_from_string (a.item)
					end
				end
			end
		end

end
