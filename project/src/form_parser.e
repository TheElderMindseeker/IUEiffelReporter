note
	description: "Summary description for {FORM_PARSER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	FORM_PARSER

feature

	parse_and_add_to_db (str: STRING)
		-- parses given string and adds it to database
		local
			parser: JSON_PARSER
			query_manager:QUERY_MANAGER
		do
			create query_manager.make
			create parser.make_with_string (str)
			parser.parse_content
			if parser.is_parsed and then parser.is_valid and then attached parser.parsed_json_value as jv then
				if attached {JSON_OBJECT} jv as j_object then
					across
						j_object.current_keys as j_key
					loop
						if attached {JSON_STRING} j_object.item (j_key.item) as j_string then
							print ("key of string: " + j_key.item.representation + " string: " + without_quotes(j_string.representation) + "%N")
						end
						if attached {JSON_ARRAY} j_object.item (j_key.item) as j_array then
							print ("name of array: " + j_key.item.representation + " values in array:%N")
							if j_array.count > 0 then
								across
									j_array.array_representation as ar_item
								loop
									if attached {JSON_OBJECT} ar_item.item as ar_object then
										across
											ar_object.current_keys as ar_key
										loop
											if attached {JSON_STRING} ar_object.item (ar_key.item) as ar_string then
												print ("key of string in array: " + ar_key.item.representation + " string: " + ar_string.representation + "%N")
											end
										end
									end
								end
							end
						end
					end
				end
			end
		end
feature{NONE}
	without_quotes(str:STRING):STRING
	--returns given string withiout quotes
	do
		if str.at (1)='"' and then str.at (str.count)='"' then
			create Result.make_from_string(str.substring (2, str.count-1))
		else
			create Result.make_empty
		end
	end
end
