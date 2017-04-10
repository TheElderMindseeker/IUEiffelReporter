note
	description: "Template for publications query"
	author: "Niyaz Ginatullin"
	date: "10.01.2017"
	revision: "1.0"

class
	TEMPLATE_PUBLICATIONS

inherit

	WITHOUT_QUOTES

	SHARED_TEMPLATE_CONTEXT

create
	make

feature -- Initialization

	make (a_courses: ITERABLE [ITERABLE [FIELD]])
			-- Reads text number template for admin page, it will be availible in get_output.
		local
			p: PATH
		do
			create publications.make
			create p.make_from_string ("www")
			p := p.appended ("/templates/query_responses")
			set_template_folder (p)
			set_template_file_name ("publications.tpl")
			set_publications (a_courses)
			template.add_value (publications, "publications")
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

	publications: LINKED_LIST [PUBLICATION]
			-- List of publications.

	set_publications (a_publications: ITERABLE [ITERABLE [FIELD]])
			-- Fills list of publications.
		require
			a_publications /= Void
		local
			publication_name: STRING
		do
			across
				a_publications as publication
			loop
				across
					publication.item as field
				loop
					if field.item.name.same_string ("publication_name") and field.item.value.repr.same_string ("%'%'") then
						publication_name := without_quotes (field.item.value.repr)
					end
				end
				if attached publication_name as a_publication_name then
					publications.force (create {PUBLICATION}.make (publication_name))
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
