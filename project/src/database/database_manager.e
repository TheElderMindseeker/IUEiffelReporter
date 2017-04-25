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
			if (create {RAW_FILE}.make_with_name (db_file_name)).exists then
				create database.make_open_read_write (db_file_name)
				is_initialized := True
			else
				create database.make_create_read_write (db_file_name)
				initialize
			end
			gather_table_info
		ensure
			database_exists: database /= Void
			database_initialized: is_initialized
		end

feature {NONE} -- Implementation

	database: SQLITE_DATABASE
			-- SQLite database connector

	field_info: HASH_TABLE [TUPLE [tbl_name, arg_type: STRING_8], STRING_8]
			-- Inner database fields info for fast search by `which_table' feature

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
			database.busy_timeout := 10000
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
			if attached row.value (column) as c_value then
				if attached create_field (row.column_name (column), c_value) as field then
					list.extend (field)
				end
			else
				if attached create_field (row.column_name (column), "") as field then
					list.extend (field)
				end
			end
		ensure
			list_extended: list.count = old list.count + 1
		end

	fill_table (r_table: detachable LINKED_LIST [LINKED_LIST [FIELD]]; cursor: SQLITE_STATEMENT_ITERATION_CURSOR)
		require
			r_table_exists: r_table /= Void
			cursor_exists: cursor /= Void
		local
			q_row: SQLITE_RESULT_ROW
			table_row: LINKED_LIST [FIELD]
			column: NATURAL
		do
			if attached {LINKED_LIST [LINKED_LIST [FIELD]]} r_table as table then
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
			table_exists: r_table /= Void
		end

	insert_report_row (arguments: ITERABLE [FIELD])
			-- Inserts new report row into the database
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
		end

	gather_table_info
			-- Process tables from the database for fast field search
		require
			database_initialized: is_initialized
			no_error: not has_error
		local
			key: STRING_8
			query_statement: SQLITE_QUERY_STATEMENT
			s_query: STRING_8
			cursor: SQLITE_STATEMENT_ITERATION_CURSOR
			q_row: SQLITE_RESULT_ROW
			tables: LINKED_LIST [STRING_8]
		do
			create field_info.make_equal (100)
			field_info.compare_objects
			create tables.make
			s_query := "SELECT tbl_name FROM sqlite_master;"
			create query_statement.make (s_query, database)
			from
				cursor := query_statement.execute_new
			until
				cursor.after
			loop
				q_row := cursor.item
				tables.extend (q_row.string_value (1))
				cursor.forth
			end
			from
				tables.start
			until
				tables.after
			loop
				s_query := "PRAGMA table_info(" + tables.item + ");"
				create query_statement.make (s_query, database)
				if not query_statement.has_error then
					from
						cursor := query_statement.execute_new
					until
						cursor.after
					loop
						q_row := cursor.item
						key := q_row.string_value (2)
						if attached key and then not field_info.has (key) then
							field_info.put (create {TUPLE [tbl_name, arg_type: STRING_8]}.default_create, key)
							if attached field_info.at (key) as tuple then
								tuple.put (tables.item, 1)
								if attached q_row.string_value (3) as arg_type then
									tuple.put (arg_type, 2)
								end
							end
						end
						cursor.forth
					end
				end
				tables.forth
			end
		ensure
			field_info_exists: field_info /= Void
		end

feature -- Access

	is_initialized: BOOLEAN
			-- Has `database' been successfully initialized?

	has_error: BOOLEAN
			-- Has any error concerning `database' occurred?

	current_report_id: INTEGER_32
			-- Report id of the last created report

	close
			-- Close database after use.
		do
			database.close
			is_initialized := False
		ensure
			not_initialized: not is_initialized
		end

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
		do
			insert_report_row (arguments)
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
				iterable_cursor.forth
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
			s_query: STRING_8
		do
			s_query := "SELECT * FROM " + table_name + " WHERE report_id = " + report_id.out + ";"
			create query_statement.make (s_query, database)
			cursor := query_statement.execute_new
			create {LINKED_LIST [LINKED_LIST [FIELD]]} Result.make
			if not query_statement.has_error and attached {LINKED_LIST [LINKED_LIST [FIELD]]} Result as table then
				fill_table (table, cursor)
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
			database_initialized: is_initialized
			no_error: not has_error
			report_exists: has_report (report_id)
		local
			delete_statement: SQLITE_MODIFY_STATEMENT
			d_query: STRING_8
		do
			d_query := "DELETE FROM " + table_name + " WHERE report_id = " + report_id.out + ";"
			create delete_statement.make (d_query, database)
			delete_statement.execute
			if delete_statement.has_error then
				has_error := True
			end
		end

	reports_by_date (start_date, end_date: DATE): ITERABLE [INTEGER_32]
			-- Finds all reports that are between `start_date' and `end_date'
		require
			dates_exist: start_date /= Void and end_date /= Void
		local
			query_statement: SQLITE_QUERY_STATEMENT
			cursor: SQLITE_STATEMENT_ITERATION_CURSOR
			s_query: STRING_8
		do
			create {LINKED_LIST [INTEGER_32]} Result.make
			if attached {LINKED_LIST [INTEGER_32]} Result as list then
				s_query := " SELECT report_id FROM reports WHERE julianday(" +
						start_date.repr + ") <= rep_start AND rep_end <= julianday(" + end_date.repr + ");"
				create query_statement.make (s_query, database)
				cursor := query_statement.execute_new
				if not query_statement.has_error then
					from
						cursor.start
					until
						cursor.after
					loop
						list.extend (cursor.item.integer_value (1))
						cursor.forth
					end
				end
			else
				has_error := True
			end
		ensure
			has_error implies Result.new_cursor.after
		end

	has_report (report_id: INTEGER_32): BOOLEAN
			-- Tells if there is a report with specified `report_id' in the database
		require
			database_initialized: is_initialized
			no_error: not has_error
		local
			query_statement: SQLITE_QUERY_STATEMENT
			cursor: SQLITE_STATEMENT_ITERATION_CURSOR
			s_query: STRING_8
		do
			s_query := "SELECT 1 FROM reports WHERE report_id = " + report_id.out + ";"
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

feature -- Utility

	list_tables: ITERABLE [STRING_8]
			-- The list of all tables in the database
		require
			database_initialized: is_initialized
			no_error: not has_error
		local
			query_statement: SQLITE_QUERY_STATEMENT
			cursor: SQLITE_STATEMENT_ITERATION_CURSOR
			s_query: STRING_8
		do
			create {LINKED_LIST [STRING_8]} Result.make
			s_query := "SELECT tbl_name FROM sqlite_master;"
			create query_statement.make (s_query, database)
			cursor := query_statement.execute_new
			if attached {LINKED_LIST [STRING_8]} Result as linked_list then
				if not query_statement.has_error then
					from
						cursor.start
					until
						cursor.after
					loop
						linked_list.extend (cursor.item.string_value (1))
						cursor.forth
					end
				else
					has_error := True
				end
			end
		ensure
			result_exists: Result /= Void
		end

	julianday (date: DATE): REAL
			-- Return julian day representation of the `date'
		require
			database_initialized: is_initialized
			no_error: not has_error
		local
			query_statement: SQLITE_QUERY_STATEMENT
			cursor: SQLITE_STATEMENT_ITERATION_CURSOR
			s_query: STRING_8
		do
			s_query := "SELECT julianday(" + date.repr + ");"
			create query_statement.make (s_query, database)
			cursor := query_statement.execute_new
			if not query_statement.has_error then
				cursor.start
				Result := cursor.item.real_value (1)
			else
				has_error := True
			end
		end

	date_from_julianday (julian: FLOAT_REPRESENTABLE): detachable DATE
			-- Convert julianday to usual date representation
		local
			query_statement: SQLITE_QUERY_STATEMENT
			cursor: SQLITE_STATEMENT_ITERATION_CURSOR
			s_query: STRING_8
		do
			s_query := "SELECT date(" + julian.repr + ");"
			create query_statement.make (s_query, database)
			cursor := query_statement.execute_new
			if not query_statement.has_error then
				cursor.start
				create Result.make_from_iso_string (cursor.item.string_value (1))
			else
				has_error := True
			end
		end

	create_field (name: STRING_8; object: ANY): detachable FIELD
			-- Create FIELD instance from given `name' and `object'
		require
			name_exists: name /= Void
			name_not_empty: name.count > 0
			object_exists: object /= Void
			object_has_supported_type: attached {INTEGER} object or attached {REAL} object or
					attached {STRING_8} object or attached {DATE} object or attached {REAL_64} object or attached {INTEGER_64} object
		do
			if attached {INTEGER} object as int then
				create Result.make (name, create {INTEGER_REPRESENTABLE}.make (int))
			elseif attached {INTEGER_64} object as int then
				create Result.make (name, create {INTEGER_REPRESENTABLE}.make (int.as_integer_32))
			elseif attached {REAL} object as float then
				if attached {DATE} date_from_julianday (create {FLOAT_REPRESENTABLE}.make (float)) as date then
					create Result.make (name, date)
				end
			elseif attached {REAL_64} object as float then
				if attached {DATE} date_from_julianday (create {FLOAT_REPRESENTABLE}.make (float.truncated_to_real)) as date then
					create Result.make (name, date)
				end
			elseif attached {STRING_8} object as str then
				create Result.make (name, create {STRING_REPRESENTABLE}.make (str))
			elseif attached {DATE} object as date then
				create Result.make (name, create {FLOAT_REPRESENTABLE}.make (julianday (date)))
			end
		ensure
			result_exists: Result /= Void
		end

	has_field (name: STRING_8): BOOLEAN
			-- Tell if there is field with provided name in the database
		require
			name_exists: name /= Void
			name_not_empty: name.count > 0
		do
			Result := field_info.has (name)
		end

	which_table (name: STRING_8): detachable TUPLE [tbl_name, arg_type: STRING_8]
			-- Tell in which table lies field given by `name'
		require
			name_exists: name /= Void
			name_not_empty: name.count > 0
			field_exists: has_field (name)
		do
			Result := field_info.at (name)
		ensure
			Result /= Void
		end

feature {QUERY_MANAGER} -- Specific queries

	query_reports: ITERABLE [ITERABLE [FIELD]]
			-- All reports present in the database
		require
			database_initialized: is_initialized
			no_error: not has_error
		local
			query_statement: SQLITE_QUERY_STATEMENT
			cursor: SQLITE_STATEMENT_ITERATION_CURSOR
			s_query: STRING_8
		do
			s_query := "[
					SELECT report_id, unit_name, head_name, rep_start, rep_end
					FROM reports;
					]"
			create query_statement.make (s_query, database)
			cursor := query_statement.execute_new
			create {LINKED_LIST [LINKED_LIST [FIELD]]} Result.make
			if not query_statement.has_error and attached {LINKED_LIST [LINKED_LIST [FIELD]]} Result as table then
				fill_table (table, cursor)
			else
				has_error := True
			end
		ensure
			result_exists: Result /= Void
		end

	list_laboratories: ITERABLE [STRING_8]
			-- List all the laboratory units known to the database
		require
			database_initialized: is_initialized
			no_error: not has_error
		local
			query_statement: SQLITE_QUERY_STATEMENT
			cursor: SQLITE_STATEMENT_ITERATION_CURSOR
			s_query: STRING_8
		do
			create {LINKED_LIST [STRING_8]} Result.make
			if attached {LINKED_LIST [STRING_8]} Result as list then
				s_query := "SELECT DISTINCT unit_name FROM reports;"
				create query_statement.make (s_query, database)
				cursor := query_statement.execute_new
				if not query_statement.has_error then
					from
						cursor.start
					until
						cursor.after
					loop
						list.extend (cursor.item.string_value (1))
						cursor.forth
					end
				else
					has_error := True
				end
			end
		ensure
			result_exists: Result /= Void
		end

	courses_taught (start_date, end_date: DATE; laboratory: STRING_REPRESENTABLE): ITERABLE [ITERABLE [FIELD]]
		-- Courses taught by a Laboratory between initial and final date.
		require
			both_dates_exist_or_neither: (start_date = Void and end_date = Void) or
					(start_date /= Void and end_date /= Void)
		local
			query_statement: SQLITE_QUERY_STATEMENT
			cursor: SQLITE_STATEMENT_ITERATION_CURSOR
			s_query: STRING_8
		do
			s_query := "SELECT crs.report_id, crs.course_id course_id, crs.course_name course_name,	crs.semester semester, crs.edu_level edu_level, crs.num_students num_students" +
					" FROM courses crs INNER JOIN reports rep ON crs.report_id = rep.report_id WHERE rep.unit_name = " + laboratory.repr
			if attached start_date as rep_start and attached end_date as rep_end then
				s_query := s_query + " AND rep.rep_start >= julianday(" + rep_start.repr + ") AND " +
						"julianday(" + rep_end.repr + ") >= rep.rep_end"
			end
			s_query := s_query + ";"
			create query_statement.make (s_query, database)
			cursor := query_statement.execute_new
			create {LINKED_LIST [LINKED_LIST [FIELD]]} Result.make
			if not query_statement.has_error and attached {LINKED_LIST [LINKED_LIST [FIELD]]} Result as table then
				fill_table (table, cursor)
			else
				has_error := True
			end
		ensure
			result_exists: Result /= Void
		end

	cumulative_info (start_date, end_date: detachable DATE; laboratory: STRING_REPRESENTABLE): ITERABLE [ITERABLE [FIELD]]
			-- Query cumulative info of the given `laboratory' unit
		require
			database_initialized: is_initialized
			no_error: not has_error
			both_dates_exist_or_neither: (start_date = Void and end_date = Void) or
					(start_date /= Void and end_date /= Void)
			laboratory_exist: laboratory /= Void
		local
			query_statement: SQLITE_QUERY_STATEMENT
			cursor: SQLITE_STATEMENT_ITERATION_CURSOR
			s_query: STRING_8
		do
			s_query := "SELECT rep.unit_name unit_name, rep.head_name head_name," +
					" date(rep.rep_start) rep_start, date(rep.rep_end) rep_end," +
					" rel.info info" +
					" FROM reports rep LEFT OUTER JOIN relevant_info rel ON rep.report_id = rel.report_id" +
					" WHERE rep.unit_name = " + laboratory.repr
			if attached start_date as rep_start and attached end_date as rep_end then
				s_query := s_query + " AND rep.rep_start >= julianday(" + rep_start.repr + ") AND " +
						"julianday(" + rep_end.repr + ") >= rep.rep_end"
			end
			s_query := s_query + ";"
			create query_statement.make (s_query, database)
			cursor := query_statement.execute_new
			create {LINKED_LIST [LINKED_LIST [FIELD]]} Result.make
			if not query_statement.has_error and attached {LINKED_LIST [LINKED_LIST [FIELD]]} Result as table then
				fill_table (table, cursor)
			else
				has_error := True
			end
		ensure
			result_exists: Result /= Void
		end

	number_of_supervised_students (start_date, end_date: DATE): ITERABLE [ITERABLE [FIELD]]
			-- Query number of supervised students by each known laboratory
		require
			database_initialized: is_initialized
			no_error: not has_error
			both_dates_exist_or_neither: (start_date = Void and end_date = Void) or
					(start_date /= Void and end_date /= Void)
		local
			query_statement: SQLITE_QUERY_STATEMENT
			cursor: SQLITE_STATEMENT_ITERATION_CURSOR
			s_query: STRING_8
		do
			s_query := "SELECT rep.unit_name unit_name, SUM(1) supervised FROM reports rep INNER JOIN supervised_students sup" +
					" ON rep.report_id = sup.report_id"
			if attached start_date as rep_start and attached end_date as rep_end then
				s_query := s_query + " WHERE rep.rep_start >= julianday(" + rep_start.repr + ") AND " +
						"julianday(" + rep_end.repr + ") >= rep.rep_end"
			end
			s_query := s_query + " GROUP BY rep.report_id;"
			create query_statement.make (s_query, database)
			cursor := query_statement.execute_new
			create {LINKED_LIST [LINKED_LIST [FIELD]]} Result.make
			if not query_statement.has_error and attached {LINKED_LIST [LINKED_LIST [FIELD]]} Result as table then
				fill_table (table, cursor)
			else
				has_error := True
			end
		ensure
			result_exists: Result /= Void
		end

	number_of_research_collaborations (start_date, end_date: DATE): ITERABLE [ITERABLE [FIELD]]
			-- Query number of research collaborations by each known laboratory
		require
			database_initialized: is_initialized
			no_error: not has_error
			both_dates_exist_or_neither: (start_date = Void and end_date = Void) or
					(start_date /= Void and end_date /= Void)
		local
			query_statement: SQLITE_QUERY_STATEMENT
			cursor: SQLITE_STATEMENT_ITERATION_CURSOR
			s_query: STRING_8
		do
			s_query := "SELECT rep.unit_name unit_name, SUM(1) collaborations FROM reports rep INNER JOIN research_collaborations col" +
					" ON rep.report_id = col.report_id"
			if attached start_date as rep_start and attached end_date as rep_end then
				s_query := s_query + " WHERE rep.rep_start >= julianday(" + rep_start.repr + ") AND " +
						"julianday(" + rep_end.repr + ") >= rep.rep_end"
			end
			s_query := s_query + " GROUP BY rep.report_id;"
			create query_statement.make (s_query, database)
			cursor := query_statement.execute_new
			create {LINKED_LIST [LINKED_LIST [FIELD]]} Result.make
			if not query_statement.has_error and attached {LINKED_LIST [LINKED_LIST [FIELD]]} Result as table then
				fill_table (table, cursor)
			else
				has_error := True
			end
		ensure
			result_exists: Result /= Void
		end

	number_of_projects_awarded_grants (start_date, end_date: DATE): ITERABLE [ITERABLE [FIELD]]
			-- Query number of projects awarded grants of each known laboratory
		require
			database_initialized: is_initialized
			no_error: not has_error
			both_dates_exist_or_neither: (start_date = Void and end_date = Void) or
					(start_date /= Void and end_date /= Void)
		local
			query_statement: SQLITE_QUERY_STATEMENT
			cursor: SQLITE_STATEMENT_ITERATION_CURSOR
			s_query: STRING_8
		do
			s_query := "SELECT rep.unit_name unit_name, SUM(1) collaborations FROM reports rep INNER JOIN grants gr" +
					" ON rep.report_id = gr.report_id"
			if attached start_date as rep_start and attached end_date as rep_end then
				s_query := s_query + " WHERE rep.rep_start >= julianday(" + rep_start.repr + ") AND " +
						"julianday(" + rep_end.repr + ") >= rep.rep_end"
			end
			s_query := s_query + " GROUP BY rep.report_id;"
			create query_statement.make (s_query, database)
			cursor := query_statement.execute_new
			create {LINKED_LIST [LINKED_LIST [FIELD]]} Result.make
			if not query_statement.has_error and attached {LINKED_LIST [LINKED_LIST [FIELD]]} Result as table then
				fill_table (table, cursor)
			else
				has_error := True
			end
		ensure
			result_exists: Result /= Void
		end

	patents_filed_or_submitted (start_date, end_date: DATE): ITERABLE [ITERABLE [FIELD]]
			-- Query number of patents filed or submitted
		require
			database_initialized: is_initialized
			no_error: not has_error
			both_dates_exist_or_neither: (start_date = Void and end_date = Void) or
					(start_date /= Void and end_date /= Void)
		local
			query_statement: SQLITE_QUERY_STATEMENT
			cursor: SQLITE_STATEMENT_ITERATION_CURSOR
			s_query: STRING_8
		do
			s_query := "SELECT pats.patent_id, pats.report_id, pats.patent_title, pats.patent_office_country FROM patents pats INNER JOIN reports rep ON pats.report_id = rep.report_id"
			if attached start_date as rep_start and attached end_date as rep_end then
				s_query := s_query + " WHERE rep.rep_start >= julianday(" + rep_start.repr + ") AND " +
						"julianday(" + rep_end.repr + ") >= rep.rep_end"
			end
			s_query := s_query + ";"
			create query_statement.make (s_query, database)
			cursor := query_statement.execute_new
			create {LINKED_LIST [LINKED_LIST [FIELD]]} Result.make
			if not query_statement.has_error and attached {LINKED_LIST [LINKED_LIST [FIELD]]} Result as table then
				fill_table (table, cursor)
			else
				has_error := True
			end
		ensure
			result_exists: Result /= Void
		end

end
