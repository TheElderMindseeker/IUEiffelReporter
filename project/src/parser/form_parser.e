note
	description: "Class that parses json string from form page"
	author: "Niyaz Guinatullin and Daniil Botnarenku"
	date: "$Date$"
	revision: "$Revision$"

class
	FORM_PARSER

create
	make

feature {NONE} -- Initialization

	make (j_str: STRING; manager: DATABASE_MANAGER)
			-- Initialize `Current'.
		require
			json_exists: j_str /= Void
			manager_exists: manager /= Void
		do
			source_json := j_str
			database_manager := manager
		ensure
			successful_json_assignment: source_json = j_str
			successful_manager_assignment: database_manager = manager
		end

feature -- Parsing

	set_json_string (j_str: STRING)
			-- Set source json string to the object.
		require
			json_exists: j_str /= Void
		do
			source_json := j_str
		ensure
			successful_assignment: source_json = j_str
		end

	set_database_manager (manager: DATABASE_MANAGER)
			-- Set database manager for grouping purposes.
		require
			manager_exists: manager /= Void
		do
			database_manager := manager
		ensure
			successful_assignment: database_manager = manager
		end

	parse
			-- Parse given json string.
		local
			parser: JSON_PARSER
		do
			create parse_result.make_equal (100)
			if attached parse_result as hash_table then
				hash_table.compare_objects
			end
			create parser.make_with_string (source_json)
			parser.parse_content
			if parser.is_parsed and then parser.is_valid and then attached parser.parsed_json_value as jv then
				if attached {JSON_OBJECT} jv as j_object then
					across
						j_object.current_keys as j_key
					loop
						if attached {JSON_STRING} j_object.item (j_key.item) as j_string then
							parse_json_string (j_key.item, j_string)
						end
						if attached {JSON_ARRAY} j_object.item (j_key.item) as j_array then
							parse_json_array (j_key.item, j_array)
						end
					end
				end
			end
		ensure
			parse_result_exists: parse_result /= Void
		end

	parse_result: detachable HASH_TABLE [LINKED_LIST [ANY], STRING_8]
			-- The records formed while parsing json, keys are table names in database.

feature {NONE} -- Implementation

	source_json: STRING
			-- The json string to be parsed.

	database_manager: DATABASE_MANAGER
			-- Database manager for data grouping purposes.

	parse_json_string (name, value: JSON_STRING)
			-- Parse json string.
		do
			if attached parse_result as hash_table then
				if attached database_manager.which_table (name.item) as db_table_result then
					if attached {STRING_8} db_table_result.at (1) as table_name and then attached {STRING_8} db_table_result.at (2) as arg_type then
						if name.item.same_string ("rep_start") and then value.item.is_empty then
							value.item.set ("10.10.2017", 1, 10)
						end
						if name.item.same_string ("rep_end") and value.item.is_empty then
							value.item.set ("31.12.2017", 1, 10)
						end
						add_field_to_hash_table (name.item, value.item, table_name, arg_type, hash_table)
					end
				end
			end
		end

	parse_json_array (name: JSON_STRING; array: JSON_ARRAY)
			-- Parse json array
		local
			record: LINKED_LIST [FIELD]
		do
			across
				array.array_representation as ar_item
			loop
				if attached {JSON_OBJECT} ar_item.item as ar_object then
					create record.make
					across
						ar_object.current_keys as ar_key
					loop
						if attached database_manager.which_table (ar_key.item.item) as db_table_result then
							if attached {JSON_STRING} ar_object.item (ar_key.item) as ar_string and then attached {STRING_8} db_table_result.at (2) as arg_type then
								add_field_to_linked_list (ar_key.item.item, ar_string.item, arg_type, record)
							end
						end
					end
					if attached parse_result as hash_table then
						if not hash_table.has (name.item) then
							hash_table.put (create {LINKED_LIST [LINKED_LIST [FIELD]]}.make, name.item)
						end
						if attached {LINKED_LIST [LINKED_LIST [FIELD]]} hash_table.at (name.item) as linked_list then
							linked_list.extend (record)
						end
					end
				end
			end
		end

	add_field_to_hash_table (name, value, table_name, arg_type: STRING_8; hash_table: HASH_TABLE [LINKED_LIST [ANY], STRING_8])
			-- Add provided `name'-`value' pair to the `hash_table' as a field
		do
			if not hash_table.has (table_name) then
				hash_table.put (create {LINKED_LIST [FIELD]}.make, table_name)
			end
			if attached hash_table.at (table_name) as linked_list then
				add_field_to_linked_list (name, value, arg_type, linked_list)
			end
		end

	add_field_to_linked_list (name, value, arg_type: STRING_8; linked_list: LINKED_LIST [ANY])
			-- Add provided `name'-`value' pair to the `hash_table' as a field
		local
			field: detachable FIELD
		do
			if arg_type.same_string ("TEXT") then
				field := database_manager.create_field (name, value)
			elseif arg_type.same_string ("INTEGER") then
				field := database_manager.create_field (name, value.to_integer)
			elseif arg_type.same_string ("REAL") then
				field := database_manager.create_field (name, create {DATE}.make_from_string (value))
			end
			if attached field as att_field then
				linked_list.extend (att_field)
			end
		end

end
