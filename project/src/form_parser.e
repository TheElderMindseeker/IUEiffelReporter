note
	description: "class that parses json string from form page and adds data to the databse"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	FORM_PARSER

create
	make
feature

	make
			--creates form parser
		do
			create tables.make (15)
			create query_manager.make
		end

	parse_and_add_to_db (str: STRING)
			-- parses given string and adds it to database
		require
			not_Void: str /= Void
		local
			parser: JSON_PARSER
		do
			create parser.make_with_string (str)
			parser.parse_content
			if parser.is_parsed and then parser.is_valid and then attached parser.parsed_json_value as jv then
				if attached {JSON_OBJECT} jv as j_object then
					across
						j_object.current_keys as j_key
					loop
						if attached {JSON_STRING} j_object.item (j_key.item) as j_string then
							print ("key of string: " + j_key.item.representation + " string: " + without_quotes (j_string.representation) + "%N")
							add_string_to_ht (without_quotes (j_key.item.representation), without_quotes (j_string.representation))
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

feature {NONE}

	add_string_to_ht (key, value: STRING)
		do
			if attached query_manager.database_manager.which_table (key) as tuple
			and then attached {STRING} tuple.at (1) as table_name then
				if not tables.has (table_name) then
					tables.force (create {LINKED_LIST [FIELD]}.make, table_name)
				end
				if attached {STRING} tuple.at (2) as type and then attached string_to_field(key,value) as field and then attached tables.at (table_name) as l_list then
					l_list.force (field)
				end
			end
		end

	string_to_field(key, value:STRING): detachable FIELD
		-- get some key and value and returns it as a field
	do
		if attached query_manager.database_manager.which_table (key) as tuple and then attached {STRING} tuple.at (2) as a_type then
			if a_type.same_string ("TEXT") then
				create Result.make(key, create {STRING_REPRESENTABLE}.make (value))
			elseif a_type.same_string ("REAL") then
				create Result.make(key, create {DATE}.make_from_string (value))
			elseif a_type.same_string ("INTEGER") then
				create Result.make(key, create {INTEGER_REPRESENTABLE}.make (value.to_integer))
			end
		end
	end
	without_quotes (str: STRING): STRING
			--returns given string withiout quotes
		require
			not_Void: str /= Void
		do
			if str.at (1) = '"' and then str.at (str.count) = '"' then
				create Result.make_from_string (str.substring (2, str.count - 1))
			else
				create Result.make_empty
			end
		ensure
			Result /= Void
		end

	tables: HASH_TABLE [LINKED_LIST [FIELD], STRING]

	query_manager: QUERY_MANAGER

end
