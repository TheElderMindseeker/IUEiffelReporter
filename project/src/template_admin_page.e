note
	description: "creates admin page  from /www/templates/form.tpl and adds needed data from database"
	author: ""
	date: "$Date: 2013-08-02 01:17:37 -0800 (Fri, 02 Aug 2013) $"
	revision: "$Revision: 92838 $"

class
	TEMPLATE_ADMIN_PAGE

inherit

	TEMPLATE_PAGE
		undefine
			default_create
		end

	SHARED_TEMPLATE_CONTEXT
		redefine
			default_create
		end

feature {NONE} -- Initialization

	default_create
			-- Reads template for admin page, it will be availible in get_output.
		local
			p: PATH
		do
			create p.make_from_string ("www")
			p := p.appended ("/templates")
			set_template_folder (p)
			set_template_file_name ("admin.tpl")
			set_reports
			template.add_value (reports, "reports")
				--template_context.enable_verbose
			template.analyze
			if attached template.output as l_output then
				output := l_output
			end
		ensure then
			created_output: output /= Void
		end

feature {NONE} -- Access to database

	reports: LINKED_LIST [REPORT]

	set_reports
		local
			query_manager: QUERY_MANAGER
			list_labs:ITERABLE[STRING]
			u_name:STRING
			h_name:STRING
			s_date:STRING
			e_date:STRING
			c_id:INTEGER
		do
			create reports.make
			create query_manager.make
			list_labs:=query_manager.list_laboratories
			across
				list_labs as lab_name
			loop
				across
					query_manager.cumulative_info (Void, Void, create{STRING_REPRESENTABLE}.make(lab_name.item)) as lab_report
				loop
					across
						lab_report.item as field
					loop
						if field.item.name.same_string ("unit_name") then
							u_name:=field.item.value.repr
						elseif field.item.name.same_string ("head_name") then
							h_name:=field.item.value.repr
						elseif field.item.name.same_string ("rep_start") then
							s_date:=field.item.value.repr
						elseif field.item.name.same_string ("rep_end") then
							e_date:=field.item.value.repr
						elseif field.item.name.same_string ("id") then
							c_id:=field.item.value.repr.to_integer
						end
					end
					if attached u_name as un and attached h_name as hn and attached s_date as sd and attached e_date as ed and attached c_id as a_id then
						reports.force (create {REPORT}.make (un, hn, sd, ed, a_id))
					end
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

		--	reports : LIST[REPORT]
		--		do
		--			create {ARRAYED_LIST[REPORT]}Result.make(5)
		--			Result.force(create {REPORT}.make ("n1", "head1", "a_start_date1", "a_end_date1", 0))
		--			Result.force(create {REPORT}.make ("n2", "head2", "a_start_date2", "a_end_date2", 0))
		--			Result.force(create {REPORT}.make ("n3", "head3", "a_start_date3", "a_end_date3", 0))
		--			Result.force(create {REPORT}.make ("n4", "head4", "a_start_date4", "a_end_date4", 0))
		--		end

end
