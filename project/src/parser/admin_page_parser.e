note
	description: "class that parses json string from admin's page"
	author: "Niyaz Ginatullin"
	date: "10.04.2017"
	revision: "1.0"

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
			-- Start date of query.

	end_date: detachable DATE
			-- End date of query.

	type_of_query: detachable STRING
			-- Type of query.

	lab_name: detachable STRING
			-- Name of laboratory.

	is_parsed: BOOLEAN
			-- Is content parsed.

feature -- Parsing

	parse
			-- Parses content and fills attributes.
		local
			parser: JSON_PARSER
		do
			is_parsed := True
			create parser.make_with_string (source_json)
			parser.parse_content
			if parser.is_parsed and then parser.is_valid and then attached parser.parsed_json_value as jv then
				if attached {JSON_OBJECT} jv as j_object then
					if attached {JSON_STRING} j_object.item ("lab_name") as n then
						create lab_name.make_from_string (n.item)
					end
					if attached {JSON_STRING} j_object.item ("type_of_query") as t then
						create type_of_query.make_from_string (t.item)
					end
					if attached {JSON_STRING} j_object.item ("end_date") as ed then
						create end_date.make_from_string (ed.item)
					end
					if attached {JSON_STRING} j_object.item ("start_date") as sd then
						create start_date.make_from_string (sd.item)
					else
						is_parsed := False
					end
				end
			end
		end

end
