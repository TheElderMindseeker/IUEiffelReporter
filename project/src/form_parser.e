note
	description: "Summary description for {FORM_PARSER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	FORM_PARSER

create make

feature

	make(json_content:STRING)
			-- Initialize `Current'.
		local
			parser: JSON_PARSER
			printer: JSON_PRETTY_STRING_VISITOR
			s: STRING_32
		do
				-- Create parser for content `json_content'
			create parser.make_with_string (json_content)
				-- Parse the content
			parser.parse_content
			if parser.is_valid and then attached parser.parsed_json_value as jv then
					-- Json content is valid, and well parsed.
					-- and the parsed json value is `jv'

					-- Let's access the glossary/title value
--				if attached {JSON_OBJECT} jv as j_ob then
--					across {LINKED_LIST[STRING]} list_of_names as name loop
--						if attached {JSON_OBJECT} j_object.item (name) as ob then
--						end
--					end
--				end
				if attached {JSON_OBJECT} jv as j_object and then attached {JSON_OBJECT} j_object.item ("name") as j_name then
					print ("name is %"" + j_name.representation + "%".%N")
				else
					print ("name was not found!%N")
				end

					-- Pretty print the parsed JSON
				create s.make_empty
				create printer.make (s)
				jv.accept (printer)
				print ("The JSON formatted using a pretty printer:%N")
				print (s)
			end
		end

feature

	list_of_names:LINKED_LIST[STRING]
	once
		create Result.make
		Result.force("name")
		Result.force ("date")
	end
end
