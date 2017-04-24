note
	description: "returns template for cumulutave info query"
	author: "Ginatullin Niyaz"
	date: "24.04.2017"
	revision: "1.0"

class
	TEMPLATE_CUMULATIVE_INFO

inherit

	SHARED_TEMPLATE_CONTEXT

create
	make

feature -- Initialization

	make (a_infos: ITERABLE [ITERABLE [FIELD]])
			-- Reads cumulative template for admin page, it will be availible in get_output.
		local
			p: PATH
		do
			create infos.make
			create p.make_from_string ("www")
			p := p.appended ("/templates/query_responses")
			set_template_folder (p)
			set_template_file_name ("cumulative_info.tpl")
			set_infos (a_infos)
			template.add_value (infos, "labinfos")
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

	infos: LINKED_LIST [CUMUL_INFO]
			-- List of cumulative info.

	set_infos (a_infos: ITERABLE [ITERABLE [FIELD]])
			-- Fills list of cumulative info.
		require
			a_infos /= Void
		local
			unit_name: STRING
			head_name: STRING
			rep_start: STRING
			rep_end: STRING
			relevant_info: STRING
		do
			across
				a_infos as info
			loop
				across
					info.item as field
				loop
					if field.item.name.same_string ("unit_name") then
						unit_name := field.item.value.usual_repr
					elseif field.item.name.same_string ("head_name") then
						head_name := field.item.value.usual_repr
					elseif field.item.name.same_string ("rep_start") then
						rep_start := field.item.value.usual_repr
					elseif field.item.name.same_string ("rep_end") then
						rep_end := field.item.value.usual_repr
					elseif field.item.name.same_string ("info") then
						relevant_info := field.item.value.usual_repr
					end
				end
				if attached unit_name as un and attached head_name as hd and attached rep_start as rs and attached rep_end as re and attached relevant_info as ri then
					infos.force (create {CUMUL_INFO}.make (un, hd, rs, re, ri))
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
