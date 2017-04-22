note
	description: "Summary description for {MEMBERSHIP}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	PRIZE

create
	make

feature

	make (a_recipient_name: STRING; a_prize_name: STRING; a_prizing_date: STRING)
		require
			a_recipient_name /= Void
			a_prize_name /= Void
			a_prizing_date /= Void
		do
			recipient_name := a_recipient_name
			prize_name := a_prize_name
			prizing_date := a_prizing_date
		ensure
			recipient_name.same_string (a_recipient_name)
			prize_name.same_string (a_prize_name)
			prizing_date.same_string (a_prizing_date)
		end

	recipient_name: STRING

	prize_name: STRING

	prizing_date:STRING

end
