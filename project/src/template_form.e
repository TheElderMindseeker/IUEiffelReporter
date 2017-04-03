note
	description: "Summary description for {HTML_TABLE_TEMPLATE}."
	author: ""
	date: "$Date: 2013-08-02 01:17:37 -0800 (Fri, 02 Aug 2013) $"
	revision: "$Revision: 92838 $"

class
	TEMPLATE_FORM

inherit

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

			-- Initialize `Current'.
		local
			p: PATH
		do
			create p.make_current
			p:=p.appended ("/tpl")
			set_template_folder (p)
			set_template_file_name ("html_table.tpl")
			template.add_value (users,"users")
--			template_context.enable_verbose
--			template.analyze
			template.get_output
			if attached template.output as l_output then
				output := l_output
			end
		end

feature -- Status
	get_output: detachable STRING
	do
		Result:=output
	end

	output: detachable STRING

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

feature --
feature {NONE} -- Implementation

	users : LIST[USER]
		local
			user : USER
		do
			create {ARRAYED_LIST[USER]}Result.make(5)
			create user.make ("John","1234312")
			Result.force(user)
			create user.make ("Peter","123456")
			Result.force(user)
			create user.make ("Mike","2343221")
			Result.force(user)
		end
end
