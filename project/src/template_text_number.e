note
	description: "Summary description for {TEXT_NUMBER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TEMPLATE_TEXT_NUMBER

inherit
	WITHOUT_QUOTES

	SHARED_TEMPLATE_CONTEXT

create
	make

feature -- Initialization

	make (pagename,text_column, number_column: STRING; a_elements: ITERABLE [ITERABLE [FIELD]])
			-- Reads text number template for admin page, it will be availible in get_output.
		local
			p: PATH
		do
			create elements.make
			create p.make_from_string ("www")
			p := p.appended ("/templates/query_responses")
			set_template_folder (p)
			set_template_file_name ("text_number.tpl")
			set_elements(a_elements)
			template.add_value (text_column, "text_column")
			template.add_value (number_column, "number_column")
			template.add_value (pagename, "pagename")
			template.add_value (elements, "elements")
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

	elements: LINKED_LIST [TEXT_NUMBER]

	set_elements (a_elements: ITERABLE [ITERABLE [FIELD]])
		local
			text: STRING
			number: INTEGER
		do
			across
				a_elements as element
			loop
				across
					element.item as field
				loop
					if field.item.name.same_string("unit_name") then
						text:=without_quotes(field.item.value.repr)
					elseif  field.item.name.same_string("supervised") or field.item.name.same_string("collaborations") or field.item.name.same_string("projects") then
						number:=field.item.value.repr.to_integer
					end
				end
				if attached text as tx then
					elements.extend (create {TEXT_NUMBER}.make (tx, number))
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

		--	reports : LIST[REPORT]
		--		do
		--			create {ARRAYED_LIST[REPORT]}Result.make(5)
		--			Result.force(create {REPORT}.make ("n1", "head1", "a_start_date1", "a_end_date1", 0))
		--			Result.force(create {REPORT}.make ("n2", "head2", "a_start_date2", "a_end_date2", 0))
		--			Result.force(create {REPORT}.make ("n3", "head3", "a_start_date3", "a_end_date3", 0))
		--			Result.force(create {REPORT}.make ("n4", "head4", "a_start_date4", "a_end_date4", 0))
		--		end

end
