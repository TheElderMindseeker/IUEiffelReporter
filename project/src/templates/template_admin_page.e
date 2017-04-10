note
	description: "creates admin page  from /www/templates/admin.tpl and adds needed data from database"
	author: "Niyaz Ginatullin"
	date: "10.04.2017"
	revision: "1.0"

class
	TEMPLATE_ADMIN_PAGE

inherit

	WITHOUT_QUOTES
		undefine
			default_create
		end

	SHARED_TEMPLATE_CONTEXT
		redefine
			default_create
		end

feature -- Initialization

	default_create
			-- Reads template for admin page, it will be availible in get_output.
		local
			p: PATH
		do
			create p.make_from_string ("www")
			p := p.appended ("/templates")
			set_template_folder (p)
			set_template_file_name ("admin.tpl")
			set_reports_and_labs
			template.add_value (reports, "reports")
			template.add_value (labs, "labs")
				--template_context.enable_verbose
			template.analyze
			template.get_output
			if attached template.output as l_output then
				output := l_output
			end
		ensure then
			created_output: output /= Void
		end

	output: detachable STRING

feature {NONE} -- Access to database

	reports: LINKED_LIST [REPORT]

	labs: ITERABLE [STRING]

	set_reports_and_labs
		local
			query_manager: QUERY_MANAGER
			u_name: STRING
			h_name: STRING
			s_date: STRING
			e_date: STRING
			c_id: INTEGER
		do
			create reports.make
			create query_manager.make
			labs := query_manager.list_laboratories
			across
				query_manager.query_reports as lab_report
			loop
				across
					lab_report.item as field
				loop
					if field.item.name.same_string ("unit_name") then
						u_name := field.item.value.repr
						u_name := without_quotes (u_name)
					elseif field.item.name.same_string ("head_name") then
						h_name := field.item.value.repr
						h_name := without_quotes (h_name)
					elseif field.item.name.same_string ("rep_start") then
						s_date := field.item.value.repr
						s_date := without_quotes (s_date)
					elseif field.item.name.same_string ("rep_end") then
						e_date := field.item.value.repr
						e_date := without_quotes (e_date)
					elseif field.item.name.same_string ("report_id") then
						c_id := field.item.value.repr.to_integer
					end
				end
				if attached u_name as un and attached h_name as hn and attached s_date as sd and attached e_date as ed and attached c_id as a_id then
					reports.force (create {REPORT}.make (un, hn, sd, ed, a_id))
				end
			end
		end

feature {NONE} -- Implementation

	set_template_folder (v: PATH)
		do
			template_context.set_template_folder (v)
		end

	set_template_file_name (v: STRING)
		do
			create template.make_from_file (v)
		end

	set_template (v: like template)
		do
			template := v
		end

	template: TEMPLATE_FILE

end
