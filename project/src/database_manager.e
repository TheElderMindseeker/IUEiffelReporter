note
	description: "Bridge class that allows suitable access to SQLite databases."
	author: "Daniil Botnarenku"
	date: "$Date$"
	revision: "$Revision$"

class
	DATABASE_MANAGER

create
	make

feature {NONE} -- Initialization

	make (db_file_name: READABLE_STRING_GENERAL)
			-- Initializes new database interface to file with name `db_file_name'
		require
			file_name_exists: db_file_name /= Void
			file_name_not_empty: db_file_name.count > 0
		do
			is_initialized := False
			has_error := False
			current_report_id := -1
			create types.default_create
			if (create {RAW_FILE}.make_with_name (db_file_name)).exists then
				create database.make_open_read_write (db_file_name)
				is_initialized := True
			else
				create database.make_create_read_write (db_file_name)
				initialize
			end
		ensure
			database_exists: database /= Void
			database_initialized: is_initialized
		end

feature {NONE} -- Implementation

	database: SQLITE_DATABASE
			-- SQLite database connector

	types: SQLITE_TYPE
			-- SQL database types

	initialize
			-- Initiailze the database by creating necessary tables
			-- This feature reads database script from `db/create.sql' file
		require
			ddl_file_exists: (create {RAW_FILE}.make_with_name ("db/create.sql")).exists
		local
			database_insert_statement: SQLITE_INSERT_STATEMENT
			ddl_file: FILE
			c_query: STRING
			ch_read: INTEGER
		do
			create {PLAIN_TEXT_FILE} ddl_file.make_open_read ("db/create.sql")
			create c_query.make_filled (' ', ddl_file.count)
			ch_read := ddl_file.read_to_string (c_query, 1, ddl_file.count)
			create database_insert_statement.make (c_query, database)
			database_insert_statement.execute
			if not database_insert_statement.has_error then
				is_initialized := True
			else
				has_error := True
			end
		ensure
			has_error /= is_initialized -- TODO: Add necessary contracts here
		end

	add_field (list: LINKED_LIST [FIELD]; row: SQLITE_RESULT_ROW; column: NATURAL_32)
			-- Adds new field to `list' from `row's `column'
		require
			list_exists: list /= Void
			row_exists: row /= Void
			column_exists: 0 < column and column <= row.count
		do
			if row.type (column) = types.integer then
				list.extend (create {FIELD}.make (row.column_name (column),
						create {INTEGER_REPRESENTABLE}.make (row.integer_value (column))))
			elseif row.type (column) = types.text then
				list.extend (create {FIELD}.make (row.column_name (column),
						create {STRING_REPRESENTABLE}.make (row.string_value (column))))
			elseif row.type (column) = types.float then
				list.extend (create {FIELD}.make (row.column_name (column),
						create {FLOAT_REPRESENTABLE}.make (row.real_value (column))))
			end
		ensure
			-- TODO: add reasonable contracts here
		end

feature -- Access

	is_initialized: BOOLEAN
			-- Has `database' been successfully initialized?

	has_error: BOOLEAN
			-- Has any error concerning `database' occurred?

	current_report_id: INTEGER_32
			-- Report id of the last created report

feature -- Management

	clear_error
			-- Resets `has_error' flag
		require
			has_error: has_error
		do
			has_error := False
		ensure
			has_no_error: not has_error
		end

	create_report (arguments: ITERABLE [FIELD])
			-- Creates new report and generates new `report_id'
		require
			database_initialized: is_initialized
			no_error: not has_error
		local
			query_statement: SQLITE_QUERY_STATEMENT
			cursor: SQLITE_STATEMENT_ITERATION_CURSOR
			q_row: SQLITE_RESULT_ROW
			s_query: STRING_8
		do
			single_insert ("reports", arguments)
			s_query := "SELECT last_insert_rowid();"
			create query_statement.make (s_query, database)
			cursor := query_statement.execute_new
			if not (query_statement.has_error or has_error) then
				cursor.start
				q_row := cursor.item
				current_report_id := q_row.integer_value (1)
			end
		ensure
			valid_current_report_id: not has_error implies current_report_id >= 0
		end

	single_insert (table_name: STRING_8; arguments: ITERABLE [FIELD])
			-- Do insertion into the specified table in the database
		require
			table_name_exists: table_name /= Void
			table_name_not_empty: table_name.count > 0
			arguments_not_empty: not arguments.new_cursor.after
			database_initialized: is_initialized
			no_error: not has_error
		local
			insert_statement: SQLITE_INSERT_STATEMENT
			i_query: STRING_8
			cursor: ITERATION_CURSOR [FIELD]
		do
			cursor := arguments.new_cursor
			i_query := "INSERT INTO " + table_name + " ("
			from
				i_query := i_query + cursor.item.name
				cursor.forth
			until
				cursor.after
			loop
				i_query := i_query + ", " + cursor.item.name
				cursor.forth
			end
			i_query := i_query + ") VALUES ("
			cursor := arguments.new_cursor
			from
				i_query := i_query + cursor.item.value.repr
				cursor.forth
			until
				cursor.after
			loop
				i_query := i_query + ", " + cursor.item.value.repr
				cursor.forth
			end
			i_query := i_query + ");"
			create insert_statement.make (i_query, database)
			insert_statement.execute
			if insert_statement.has_error then
				has_error := True
			end
		end

	multiple_insert (table_name: STRING_8; arguments: ITERABLE [ITERABLE [FIELD]])
			-- Insert multiple rows into the specified table
		require
			table_name_exists: table_name /= Void
			table_name_not_empty: table_name.count > 0
			arguments_not_empty: not arguments.new_cursor.after and
					across arguments as argument all not argument.item.new_cursor.after end
			database_initialized: is_initialized
			no_error: not has_error
		local
			insert_statement: SQLITE_INSERT_STATEMENT
			i_query: STRING_8
			iterable_cursor: ITERATION_CURSOR [ITERABLE [FIELD]]
			cursor: ITERATION_CURSOR [FIELD]
		do
			from
				iterable_cursor := arguments.new_cursor
			until
				iterable_cursor.after or has_error
			loop
				cursor := iterable_cursor.item.new_cursor
				i_query := "INSERT INTO " + table_name + " ("
				from
					i_query := i_query + cursor.item.name
					cursor.forth
				until
					cursor.after
				loop
					i_query := i_query + ", " + cursor.item.name
					cursor.forth
				end
				i_query := i_query + ") VALUES ("
				cursor := iterable_cursor.item.new_cursor
				from
					i_query := i_query + cursor.item.value.repr
					cursor.forth
				until
					cursor.after
				loop
					i_query := i_query + ", " + cursor.item.value.repr
					cursor.forth
				end
				i_query := i_query + ");"
				create insert_statement.make (i_query, database)
				insert_statement.execute
				if insert_statement.has_error then
					has_error := True
				end
			end
		end

	single_select (table_name: STRING_8; report_id: INTEGER_32): ITERABLE [FIELD]
			-- Selects the data from the table with `table_name' referenced to report with `report_id'.
		require
			table_name_exists: table_name /= Void
			table_name_not_empty: table_name.count > 0
			database_initialized: is_initialized
			no_error: not has_error
			report_exists: has_report (report_id)
		local
			query_statement: SQLITE_QUERY_STATEMENT
			cursor: SQLITE_STATEMENT_ITERATION_CURSOR
			q_row: SQLITE_RESULT_ROW
			s_query: STRING_8
			column: NATURAL
		do
			s_query := "SELECT * FROM " + table_name + " WHERE report_id = " + report_id.out + ";"
			create query_statement.make (s_query, database)
			cursor := query_statement.execute_new
			create {LINKED_LIST [FIELD]} Result.make
			if not query_statement.has_error and attached {LINKED_LIST [FIELD]} Result as list then
				cursor.start
				q_row := cursor.item
				from
					column := 1
				until
					column > q_row.count
				loop
					add_field (list, q_row, column)
					column := column + 1
				end
			else
				has_error := True
			end
		ensure
			result_exists: Result /= Void
			result_not_empty: not Result.new_cursor.after
		end

	multiple_select (table_name: STRING_8; report_id: INTEGER_32): ITERABLE [ITERABLE [FIELD]]
			-- Selects the data from the table with `table_name' referenced to report with `report_id'.
		require
			table_name_exists: table_name /= Void
			table_name_not_empty: table_name.count > 0
			database_initialized: is_initialized
			no_error: not has_error
			report_exists: has_report (report_id)
		local
			query_statement: SQLITE_QUERY_STATEMENT
			cursor: SQLITE_STATEMENT_ITERATION_CURSOR
			q_row: SQLITE_RESULT_ROW
			s_query: STRING_8
			table_row: LINKED_LIST [FIELD]
			column: NATURAL
		do
			s_query := "SELECT * FROM " + table_name + " WHERE report_id = " + report_id.out + ";"
			create query_statement.make (s_query, database)
			cursor := query_statement.execute_new
			create {LINKED_LIST [LINKED_LIST [FIELD]]} Result.make
			if not query_statement.has_error and attached {LINKED_LIST [LINKED_LIST [FIELD]]} Result as table then
				from
					cursor.start
				until
					cursor.after
				loop
					table.extend (create {LINKED_LIST [FIELD]}.make)
					table_row := table.last
					q_row := cursor.item
					from
						column := 1
					until
						column > q_row.count
					loop
						add_field (table_row, q_row, column)
						column := column + 1
					end
					cursor.forth
				end
			else
				has_error := True
			end
		ensure
			result_exists: Result /= Void
			result_not_empty_if_not_error: Result.new_cursor.after implies not has_error
		end

	single_update (table_name: STRING_8; report_id: INTEGER_32; arguments: ITERABLE [FIELD])
			-- Do update of the specified table in the database
		require
			table_name_exists: table_name /= Void
			table_name_not_empty: table_name.count > 0
			arguments_not_empty: not arguments.new_cursor.after
			database_initialized: is_initialized
			no_error: not has_error
			report_exists: has_report (report_id)
		local
			update_statement: SQLITE_MODIFY_STATEMENT
			u_query: STRING_8
			cursor: ITERATION_CURSOR [FIELD]
		do
			cursor := arguments.new_cursor
			u_query := "UPDATE " + table_name + " SET "
			from
				u_query := u_query + cursor.item.name + "=" + cursor.item.value.repr
				cursor.forth
			until
				cursor.after
			loop
				u_query := u_query + ", " + cursor.item.name + "=" + cursor.item.value.repr
				cursor.forth
			end
			u_query := u_query + " WHERE report_id = " + report_id.out + ";"
			create update_statement.make (u_query, database)
			update_statement.execute
			if update_statement.has_error then
				has_error := True
			end
		end

	multiple_delete (table_name: STRING_8; report_id: INTEGER_32)
			-- Deletes all rows with `report_id' from the table
		require
			table_name_exists: table_name /= Void
			table_name_not_empty: table_name.count > 0
			arguments_not_empty: not arguments.new_cursor.after
			database_initialized: is_initialized
			no_error: not has_error
			report_exists: has_report (report_id)
		local
			delete_statement: SQLITE_MODIFY_STATEMENT
			d_query: STRING_8
		do
			d_query := "DELETE FROM " + table_name + " WHERE report_id = " + report_id.out
			create delete_statement.make (d_query, database)
			delete_statement.execute
			if delete_statement.has_error then
				has_error := True
			end
		end

--	multiple_update (table_name: STRING_8; report_id: INTEGER_32; arguments: ITERABLE [ITERABLE [FIELD]])
--			-- Update multiple rows of the specified table
--		require
--			table_name_exists: table_name /= Void
--			table_name_not_empty: table_name.count > 0
--			arguments_not_empty: not arguments.new_cursor.after and
--					across arguments as argument all not argument.item.new_cursor.after end
--			database_initialized: is_initialized
--			no_error: not has_error
--		local
--			update_statement: SQLITE_MODIFY_STATEMENT
--			u_query: STRING_8
--			iterable_cursor: ITERATION_CURSOR [ITERABLE [FIELD]]
--			cursor: ITERATION_CURSOR [FIELD]
--		do
--			from
--				iterable_cursor := arguments.new_cursor
--			until
--				iterable_cursor.after or has_error
--			loop
--				cursor := iterable_cursor.item.new_cursor
--				u_query := "UPDATE " + table_name + " SET "
--				from
--					u_query := u_query + cursor.item.name + "=" + cursor.item.value.repr
--					cursor.forth
--				until
--					cursor.after
--				loop
--					u_query := u_query + ", " + cursor.item.name + "=" + cursor.item.value.repr
--					cursor.forth
--				end
--				u_query := u_query + " WHERE report_id = " + report_id.out + ";"
--				create update_statement.make (u_query, database)
--				update_statement.execute
--				if update_statement.has_error then
--					has_error := True
--				end
--			end
--		end

	has_report (report_id: INTEGER_32): BOOLEAN
			-- Tells if there is a report with specified `report_id' in the database
		require
			database_initialized: is_initialized
			no_error: not has_error
		local
			query_statement: SQLITE_QUERY_STATEMENT
			cursor: SQLITE_STATEMENT_ITERATION_CURSOR
			s_query: STRING_8 -- TODO: Make s_query class feature
		do
			s_query := "SELECT 1 FROM reports WHERE reports_id = " + report_id.out + ";"
			create query_statement.make (s_query, database)
			cursor := query_statement.execute_new
			cursor.start
			if not query_statement.has_error then
				if cursor.after then
					Result := False
				else
					Result := True
				end
			else
				has_error := True
				Result := False
			end
		ensure
			has_error implies not Result
		end

end
