note
	description: "handels administrator's panel"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ADMIN_PAGE_HANDLER

inherit

	WSF_URI_HANDLER

create
	make

feature

	make
		do
		end

feature

	execute (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Execute handler for `req' and respond in `res'.
			-- returns administator panel
		local
			temp: TEMPLATE_ADMIN_PAGE
			admin_parser:ADMIN_PAGE_PARSER
			input_data:STRING
			number_text_temp:TEMPLATE_TEXT_NUMBER
			courses_taught_template:TEMPLATE_COURSES_TAUGHT
			publications_template:TEMPLATE_PUBLICATIONS
			query_manager:QUERY_MANAGER
		do
			if req.is_get_request_method then
				create temp
				if attached temp.output as body then
					res.put_string (body)
				end
			elseif req.is_post_request_method then
				if attached req.content_length_value as con_len then
					create input_data.make (con_len.to_integer_32)
					req.read_input_data_into (input_data)
					create admin_parser.make (input_data)
					admin_parser.parse
					if attached admin_parser.type_of_query as type then
						create query_manager.make
						if type.same_string ("number_of_supervised_students") and attached admin_parser.start_date as sd and attached admin_parser.end_date as ed then
							create number_text_temp.make ("Supervised students","Name of Laboratory", "Number of Supervised students", query_manager.number_of_supervised_students (sd, ed))
							if attached number_text_temp.output as output then
								res.put_string (output)
							end
						elseif type.same_string ("number_of_research_collaborations") and attached admin_parser.start_date as sd and attached admin_parser.end_date as ed then
							create number_text_temp.make ("Research collaborations","Name of Laboratory", "Number of Research collaborations", query_manager.number_of_research_collaborations (sd, ed))
							if attached number_text_temp.output as output then
								res.put_string (output)
							end
						elseif type.same_string ("number_of_projects_awarded_grants") and attached admin_parser.start_date as sd and attached admin_parser.end_date as ed then
							create number_text_temp.make ("Projects awarded grants","Name of Laboratory", "Number of Projects awarded grants", query_manager.number_of_projects_awarded_grants (sd, ed))
							if attached number_text_temp.output as output then
								res.put_string (output)
							end
							--TODO need to fix bug in query_manager.courses_taught
						elseif type.same_string ("courses_taught") and attached admin_parser.start_date as sd and attached admin_parser.end_date as ed and attached admin_parser.lab_name as ln then
							create courses_taught_template.make (ln, query_manager.courses_taught(sd, ed, create {STRING_REPRESENTABLE}.make (ln)))
							if attached courses_taught_template.output as output then
								res.put_string (output)
							end
						elseif type.same_string ("query_publications") and attached admin_parser.start_date as sd and attached admin_parser.end_date as ed and attached admin_parser.lab_name as ln then
							create publications_template.make (query_manager.query_publications (sd, ed))
							if attached publications_template.output as output then
								res.put_string (output)
							end
						end
						query_manager.database_manager.close
					end
				end
			end
		end
end
