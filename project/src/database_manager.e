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

	initialize
			-- Initiailze the database by creating necessary tables
			-- This feature reads database script from db/create.sql file
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

feature -- Access

	is_initialized: BOOLEAN
			-- Has `database' been successfully initialized?

	has_error: BOOLEAN
			-- Has any error concerning `database' occirred?

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

	insert (table_name: STRING_8; arguments: ITERABLE [FIELD])
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
				cursor.forth
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

	single_select (table_name: STRING_8; report_id: INTEGER_32): ITERABLE [ANY]
			-- Selects the data from the table with `table_name' referenced to report with `report_id'
		require
			report_exists: has_report (report_id)
		do
			--
		end

	has_report (report_id: INTEGER_32): BOOLEAN
			-- Tells if there is a report with specified `report_id' in the database
		require
			database_initialized: is_initialized
		local
			query_statement: SQLITE_QUERY_STATEMENT
			cursor: SQLITE_STATEMENT_ITERATION_CURSOR
			s_query: STRING_8 -- TODO: Make s_query class global
		do
			s_query := "SELECT 1 FROM reports WHERE reports_id = " + report_id.out + ";"
			create query_statement.make (s_query, database)
			cursor := query_statement.execute_new
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
