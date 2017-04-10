note
	description: "Template for query if in data base no asked info"
	author: "Andrey Pavlenko"
	date: "10.04.2017"
	revision: "1.0"

class
	TEMPLATE_ADMIN_QUERY_ERROR

inherit

	SHARED_TEMPLATE_CONTEXT

create
	make

feature -- Initialization

	make
			-- Initialize `Current'.
		local
			p: PATH
		do
			create p.make_from_string ("www")
			p := p.appended ("/templates/query_responses")
			set_template_folder (p)
			set_template_file_name ("error.tpl")
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
