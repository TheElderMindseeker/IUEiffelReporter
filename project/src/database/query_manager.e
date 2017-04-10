note
	description: "Class that does all the needed queries to the database."
	author: "Daniil Botnarenku"
	date: "$Date$"
	revision: "$Revision$"

class
	QUERY_MANAGER

create
	make

feature {NONE} -- Initialization

	make
			-- Initialization for `Current'.
		do
			create database_manager.make ("reports.db")
		ensure
			no_error: not database_manager.has_error
		end

feature -- Access

	database_manager: DATABASE_MANAGER
			-- The bridge to the database.

feature -- Access

	query_reports: ITERABLE [ITERABLE [FIELD]]
			-- All reports present in the database
		do
			Result := database_manager.query_reports
		end

	query_publications (start_date, end_date: DATE): ITERABLE [ITERABLE [FIELD]]
			-- All publications of the university in a given year.
		require
			both_dates_exist_or_neither: (start_date = Void and end_date = Void) or
					(start_date /= Void and end_date /= Void)
		local
			report_id_cursor: ITERATION_CURSOR [INTEGER_32]
			publication_cursor: ITERATION_CURSOR [ITERABLE [FIELD]]
		do
			create {LINKED_LIST [ITERABLE [FIELD]]} Result.make
			if attached {LINKED_LIST [ITERABLE [FIELD]]} Result as table then
				from
					report_id_cursor := database_manager.reports_by_date (start_date, end_date).new_cursor
				until
					report_id_cursor.after
				loop
					from
						publication_cursor := database_manager.multiple_select
								("publications", report_id_cursor.item).new_cursor
					until
						publication_cursor.after
					loop
						table.extend (publication_cursor.item)
						publication_cursor.forth
					end
					report_id_cursor.forth
				end
			end
		end

	list_laboratories: ITERABLE [STRING_8]
			-- List all the laboratory units known to the database
		do
			Result := database_manager.list_laboratories
		ensure
			result_exists: Result /= Void
		end

	cumulative_info (start_date, end_date: detachable DATE; laboratory: STRING_REPRESENTABLE): ITERABLE [ITERABLE [FIELD]]
			-- Query cumulative info of the given `laboratory' unit
		require
			database_initialized: database_manager.is_initialized
			no_error: not database_manager.has_error
			both_dates_exist_or_neither: (start_date = Void and end_date = Void) or
					(start_date /= Void and end_date /= Void)
			laboratory_exist: laboratory /= Void
		do
			Result := database_manager.cumulative_info (start_date, end_date, laboratory)
		ensure
			result_exists: Result /= Void
		end

	courses_taught (start_date, end_date: DATE; laboratory: STRING_REPRESENTABLE): ITERABLE [ITERABLE [FIELD]]
			-- Courses taught by a Laboratory between initial and final date.
		require
			both_dates_exist_or_neither: (start_date = Void and end_date = Void) or
					(start_date /= Void and end_date /= Void)
		do
			Result := database_manager.courses_taught (start_date, end_date, laboratory)
		ensure
			result_exists: Result /= Void
		end

	number_of_supervised_students (start_date, end_date: DATE): ITERABLE [ITERABLE [FIELD]]
			-- Query number of supervised students by each known laboratory
		require
			both_dates_exist_or_neither: (start_date = Void and end_date = Void) or
					(start_date /= Void and end_date /= Void)
		do
			Result := database_manager.number_of_supervised_students (start_date, end_date)
		ensure
			result_exists: Result /= Void
		end

	number_of_research_collaborations (start_date, end_date: DATE): ITERABLE [ITERABLE [FIELD]]
			-- Query number of research collaborations by each known laboratory
		require
			both_dates_exist_or_neither: (start_date = Void and end_date = Void) or
					(start_date /= Void and end_date /= Void)
		do
			Result := database_manager.number_of_research_collaborations (start_date, end_date)
		ensure
			result_exists: Result /= Void
		end

	number_of_projects_awarded_grants (start_date, end_date: DATE): ITERABLE [ITERABLE [FIELD]]
			-- Query number of projects awarded grants of each known laboratory
		require
			both_dates_exist_or_neither: (start_date = Void and end_date = Void) or
					(start_date /= Void and end_date /= Void)
		do
			Result := database_manager.number_of_projects_awarded_grants (start_date, end_date)
		ensure
			result_exists: Result /= Void
		end

	patents_filed_or_submitted (start_date, end_date: DATE): ITERABLE [ITERABLE [FIELD]]
			-- Query patents filed or submitted during the period
		require
			both_dates_exist_or_neither: (start_date = Void and end_date = Void) or
					(start_date /= Void and end_date /= Void)
		do
			Result := database_manager.patents_filed_or_submitted (start_date, end_date)
		ensure
			result_exists: Result /= Void
		end

invariant
	database_manager_active: database_manager /= Void and then database_manager.is_initialized

end
