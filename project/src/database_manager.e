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

feature {DATABASE_MANAGER} -- Implementation

	database: SQLITE_DATABASE
			-- SQLite database connector

	initialize
			-- Initiailze the database by creating necessary tables
			-- This feature reads database script from db/create.sql file
		local
			database_insert_statement: SQLITE_INSERT_STATEMENT
			ddl_file: FILE
			c_query: STRING
			ch_read: INTEGER
		require
			ddl_file_exists: (create {RAW_FILE}.make_with_name ("db/create.sql")).exists
		do
			create {PLAIN_TEXT_FILE} ddl_file.make_open_read ("db/create.sql")
			create c_query.make_filled (' ', ddl_file.count)
			ch_read := ddl_file.read_to_string (c_query, 1, ddl_file.count)
			create database_insert_statement.make (c_query, database)
			database_insert_statement.execute
			if not database_insert_statement.has_error then
				is_initialized := True
			end
		ensure
			True -- TODO: Add necessary contracts here
		end

feature -- Access

	is_initialized: BOOLEAN
			-- Has `database' been successfully initialized?

feature -- Management

end
