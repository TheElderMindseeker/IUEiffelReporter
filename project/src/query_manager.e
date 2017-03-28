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

feature {NONE} -- Implementation

	database_manager: DATABASE_MANAGER
			-- The bridge to the database.

feature -- Access

	query_publications (start_date, end_date: DATE): ITERABLE [ITERABLE [FIELD]]
			-- All publications of the university in a given year.
		require
			dates_exist: start_date /= Void and end_date /= Void
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

	courses_taught (start_date, end_date: DATE; laboratory: STRING_REPRESENTABLE): ITERABLE [ITERABLE [FIELD]]
			-- Courses taught by a Laboratory between initial and final date.
		do
			--
		end

invariant
	database_manager_active: database_manager /= Void and then database_manager.is_initialized

end
