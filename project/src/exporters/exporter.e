note
	description: "Interface for all data exporter classes."
	author: "Daniil Botnarenku"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EXPORTER

feature -- Access

	report_id: INTEGER_32 assign set_report_id
			-- Report id to get the data from.

	create_data_file
			-- Create the data representation in wide-used format.
		deferred
		ensure
			data_file /= Void
		end

	data_file: detachable STRING
			-- Get the result of the data export.

feature -- Set up

	set_report_id (id: INTEGER_32)
			-- Set report id to export data from.
		do
			report_id := id
		ensure
			report_id = id
		end

end
