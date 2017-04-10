note
	description: "handels administrator's panel"
	author: "Niyaz Ginatullin"
	date: "10.04.2017"
	revision: "1.0"

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
			admin_parser: ADMIN_PAGE_PARSER
			input_data: STRING
			query_manager: QUERY_MANAGER
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
						if attached handle_query (type, query_manager, admin_parser) as o then
							res.put_string (o)
						end
						query_manager.database_manager.close
					end
				end
			end
		end

feature {NONE} --Implementation

	handle_query (type: STRING; query_manager: QUERY_MANAGER; admin_parser: ADMIN_PAGE_PARSER): detachable STRING
			--retruns answer for query
		require
			is_availible_type_of_query: is_availible_type (type)
			query_manager_is_not_Void: query_manager /= Void
			content_is_parsed: admin_parser.is_parsed
		local
			has_info: BOOLEAN
			number_text_temp: TEMPLATE_TEXT_NUMBER
			courses_taught_template: TEMPLATE_COURSES_TAUGHT
			publications_template: TEMPLATE_PUBLICATIONS
			error: TEMPLATE_ADMIN_QUERY_ERROR
		do
			if type.same_string ("number_of_supervised_students") and attached admin_parser.start_date as sd and attached admin_parser.end_date as ed then
				if attached query_manager.number_of_supervised_students (sd, ed) then
					has_info := False
				else
					has_info := True
					create number_text_temp.make ("Supervised students", "Name of Laboratory", "Number of Supervised students", query_manager.number_of_supervised_students (sd, ed))
					if attached number_text_temp.output as o then
						create Result.make_from_string (o)
					end
				end
			elseif type.same_string ("number_of_research_collaborations") and attached admin_parser.start_date as sd and attached admin_parser.end_date as ed then
				if attached query_manager.number_of_research_collaborations (sd, ed) then
					has_info := False
				else
					has_info := True
					create number_text_temp.make ("Supervised students", "Name of Laboratory", "Number of Supervised students", query_manager.number_of_supervised_students (sd, ed))
					if attached number_text_temp.output as output then
						create number_text_temp.make ("Research collaborations", "Name of Laboratory", "Number of Research collaborations", query_manager.number_of_research_collaborations (sd, ed))
						if attached number_text_temp.output as o then
							create Result.make_from_string (o)
						end
					end
				end
			elseif type.same_string ("number_of_projects_awarded_grants") and attached admin_parser.start_date as sd and attached admin_parser.end_date as ed then
				if attached query_manager.number_of_projects_awarded_grants (sd, ed) then
					has_info := False
				else
					has_info := True
					create number_text_temp.make ("Projects awarded grants", "Name of Laboratory", "Number of Projects awarded grants", query_manager.number_of_projects_awarded_grants (sd, ed))
					if attached number_text_temp.output as o then
						create Result.make_from_string (o)
					end
				end
			elseif type.same_string ("courses_taught") and attached admin_parser.start_date as sd and attached admin_parser.end_date as ed and attached admin_parser.lab_name as ln then
				if attached query_manager.courses_taught (sd, ed, create {STRING_REPRESENTABLE}.make (ln)) then
					has_info := False
				else
					has_info := True
					create courses_taught_template.make (ln, query_manager.courses_taught (sd, ed, create {STRING_REPRESENTABLE}.make (ln)))
					if attached courses_taught_template.output as o then
						create Result.make_from_string (o)
					end
				end
			elseif type.same_string ("query_publications") and attached admin_parser.start_date as sd and attached admin_parser.end_date as ed and attached admin_parser.lab_name as ln then
				if attached query_manager.query_publications (sd, ed) then
					has_info := False
				else
					has_info := True
					create publications_template.make (query_manager.query_publications (sd, ed))
					if attached publications_template.output as o then
						create Result.make_from_string (o)
					end
				end
			end
			if not has_info then
				create error.make
				if attached error.output as o then
					create Result.make_from_string (o)
				end
			end
		ensure
			Result_exists: is_availible_type (type) implies Result /= Void
		end

	is_availible_type (type: STRING): BOOLEAN
		require
			type_is_not_empty: type /= Void
		do
			Result := False
			Result := Result or type.same_string ("number_of_supervised_students")
			Result := Result or type.same_string ("number_of_research_collaborations")
			Result := Result or type.same_string ("number_of_projects_awarded_grants")
			Result := Result or type.same_string ("courses_taught")
			Result := Result or type.same_string ("query_publications")
		end

end
