note
	description: "Summary description for {COLLABORATION}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	COLLABORATION

create
	make

feature

	make (a_installation_country: STRING; a_installation_name: STRING; a_installation_department: STRING; a_contacts: STRING; a_nature_of_collaboration: STRING; a_id: INTEGER)
			-- creates report about some unit, that contains a lot general information abut this report
		require
			a_installation_country /= Void
			a_installation_name /= Void
			a_installation_department /= Void
			a_contacts /= Void
			a_nature_of_collaboration /= Void
		do
			id := a_id
			installation_country := a_installation_country
			installation_name := a_installation_name
			installation_department := a_installation_department
			contacts := a_contacts
			nature_of_collaboration := a_nature_of_collaboration
		ensure
			id = a_id
			installation_country.same_string(a_installation_country)
			nature_of_collaboration.same_string(a_nature_of_collaboration)
			installation_name.same_string(a_installation_name)
			installation_department.same_string(a_installation_department)
			contacts.same_string(a_contacts)
		end

	id: INTEGER

	installation_country: STRING

	installation_name: STRING

	installation_department: STRING

	contacts: STRING

	nature_of_collaboration: STRING

end
