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
		ensure
			database_exists: database /= Void
			database_initialized: is_initialized
		end

feature {NONE} -- Implementation

	database: SQLITE_DATABASE
			-- SQLite database connector

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
			if attached row.value (column) as c_value then
				if attached create_field (row.column_name (column), c_value) as field then
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
		ensure
			valid_current_report_id: not has_error implies current_report_id >= 0
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

	create_report (unit_name, head_name: STRING_8; rep_start, rep_end: DATE)
			-- Creates new report and generates new `report_id'
		require
			arguments_exist: unit_name /= Void and head_name /= Void and
					rep_start /= Void and rep_end /= Void
		local
			arguments: LINKED_LIST [FIELD]
		do
			create arguments.make
			arguments.extend (create {FIELD}.make ("unit_name", create {STRING_REPRESENTABLE}.make (unit_name)))
			arguments.extend (create {FIELD}.make ("head_name", create {STRING_REPRESENTABLE}.make (head_name)))
			arguments.extend (create {FIELD}.make ("rep_start", rep_start))
			arguments.extend (create {FIELD}.make ("rep_end", rep_end))
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
						start_date.repr + ") <= start_date AND end_date <= julianday(" + end_date.repr + ");"
				create query_statement.make (s_query, database)
				cursor := query_statement.execute_new
				if not query_statement.has_error then
					from
						cursor.start
					until
						cursor.after
					loop
						list.extend (cursor.item.integer_value (0))
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

feature -- Utility

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

	create_field (name: STRING_8; object: ANY): detachable FIELD
			-- Create FIELD instance from given `name' and `object'
		require
			name_exists: name /= Void
			name_not_empty: name.count > 0
			object_exists: object /= Void
			object_has_supported_type: attached {INTEGER} object or attached {REAL} object or
					attached {STRING_8} object or attached {DATE} object
		do
			if attached {INTEGER} object as int then
				create Result.make (name, create {INTEGER_REPRESENTABLE}.make (int))
			elseif attached {REAL} object as float then
				create Result.make (name, create {FLOAT_REPRESENTABLE}.make (float))
			elseif attached {STRING_8} object as str then
				create Result.make (name, create {STRING_REPRESENTABLE}.make (str))
			elseif attached {DATE} object as date then
				create Result.make (name, date)
			end
		ensure
			result_exists: Result /= Void
		end

feature {QUERY_MANAGER} -- Specific queries

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
				s_query := "SELECT DISCTINCT unit_name FROM reports;"
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

	cumulative_info (start_date, end_date: DATE; laboratory: STRING_REPRESENTABLE): ITERABLE [ITERABLE [FIELD]]
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
			s_query := "SELECT rep.unit_name, rep.head_name," +
					" date(rep.rep_start) start_date, date(rep.rep_end) end_date" +
					" rel.info" +
					" FROM reports rep INNER JOIN relevant_info rel ON rep.report_id = rel.report_id" +
					" WHERE rep.unit_name = " + laboratory.repr
			if start_date /= Void then
				s_query := s_query + " AND rep.start_date <= julianday(" + start_date.repr + ") AND " +
						"julianday(" + end_date.repr + ") <= rep.end_date"
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
			s_query := "SELECT rep.unit_name, SUM(1) supervised FROM reports rep INNER JOIN supervised_students sup" +
					" ON rep.report_id = sup.report_id"
			if start_date /= Void then
				s_query := s_query + " WHERE rep.start_date <= julianday(" + start_date.repr + ") AND " +
						"julianday(" + end_date.repr + ") <= rep.end_date"
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
			s_query := "SELECT rep.unit_name, SUM(1) collaborations FROM reports rep INNER JOIN research_collaborations col" +
					" ON rep.report_id = res.report_id"
			if start_date /= Void then
				s_query := s_query + " WHERE rep.start_date <= julianday(" + start_date.repr + ") AND " +
						"julianday(" + end_date.repr + ") <= rep.end_date"
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
			q_row: SQLITE_RESULT_ROW
			s_query: STRING_8
			table_row: LINKED_LIST [FIELD]
			column: NATURAL
		do
			s_query := "SELECT rep.unit_name, SUM(1) collaborations FROM reports rep INNER JOIN grants gr" +
					" ON rep.report_id = gr.report_id"
			if start_date /= Void then
				s_query := s_query + " WHERE rep.start_date <= julianday(" + start_date.repr + ") AND " +
						"julianday(" + end_date.repr + ") <= rep.end_date"
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
			s_query := "SELECT patent_id, report_id, patent_title, patent_office_country FROM patents_and_ip" +
					" WHERE type = 'P'"
			if start_date /= Void then
				s_query := s_query + " AND rep.start_date <= julianday(" + start_date.repr + ") AND " +
						"julianday(" + end_date.repr + ") <= rep.end_date"
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
