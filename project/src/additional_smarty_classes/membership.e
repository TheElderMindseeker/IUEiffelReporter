note
	description: "Summary description for {MEMBERSHIP}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	MEMBERSHIP

create
	make

feature

	make (a_member_name: STRING; a_membership_date: STRING)
		require
			a_member_name /= Void
			a_membership_date /= Void
		do
			member_name := a_member_name
			membership_date := a_membership_date
		ensure
			member_name.same_string (a_member_name)
			membership_date.same_string (a_membership_date)
		end

	member_name: STRING

	membership_date: STRING

end
