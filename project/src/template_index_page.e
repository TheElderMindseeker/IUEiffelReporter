note
	description: "Summary description for {TEMPLATE_INDEX_PAGE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TEMPLATE_INDEX_PAGE

inherit

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
			set_template_file_name ("index.tpl")
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
