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
		undefine
			default_create
		end

	ANY
		redefine
			default_create
		end

create
	default_create

feature {NONE} -- Initialization

	default_create
			-- reades template for admin page, it will be availible in get_output
		local
			p: PATH
		do
			create p.make_from_string ("www")
			p := p.appended ("/templates")
			set_template_folder (p)
			set_template_file_name ("admin.tpl")
				--template.add_value (reports, "reports")
				--template_context.enable_verbose
			template.analyze
			template.get_output
			if attached template.output as l_output then
				output := l_output
			end
		end

feature {NONE} --Status

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
