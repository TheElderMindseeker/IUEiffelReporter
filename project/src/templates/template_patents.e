note
	description: "template for patents query"
	author: "Ginatullin Niyaz"
	date: "24.04.2017"
	revision: "1.0"

class
	TEMPLATE_PATENTS

inherit

	SHARED_TEMPLATE_CONTEXT

create
	make

feature -- Initialization

	make (a_patents: ITERABLE [ITERABLE [FIELD]])
			-- Reads cumulative template for admin page, it will be availible in get_output.
		local
			p: PATH
		do
			create patents.make
			create p.make_from_string ("www")
			p := p.appended ("/templates/query_responses")
			set_template_folder (p)
			set_template_file_name ("patents.tpl")
			set_patents (a_patents)
			template.add_value (patents, "patents")
			template.analyze
			template.get_output
			if attached template.output as l_output then
				output := l_output
			end
		ensure then
			created_output: output /= Void
		end

	output: detachable STRING
			-- Output of template.

feature {NONE} -- Implementation

	patents: LINKED_LIST [PATENT]
			-- List of cumulative info.

	set_patents (a_patents: ITERABLE [ITERABLE [FIELD]])
			-- Fills list of cumulative info.
		require
			a_patents /= Void
		local
			patent_title: STRING
			patent_office_country: STRING
		do
			across
				a_patents as patent
			loop
				across
					patent.item as field
				loop
					if field.item.name.same_string ("patent_title") then
						patent_title := field.item.value.usual_repr
					elseif field.item.name.same_string ("patent_office_country") then
						patent_office_country := field.item.value.usual_repr
					end
				end
				if attached patent_title as pt and attached patent_office_country as poc then
					patents.force (create {PATENT}.make (pt, poc))
				end
			end
		end

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
