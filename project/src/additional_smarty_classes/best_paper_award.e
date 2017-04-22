note
	description: "This class is additional class for creating template. It contains attributes only"
	author: "Niyaz Ginatullin"
	date: "10.04.2017"
	revision: "1.0"

class
	BEST_PAPER_AWARD

create
	make

feature

	make (a_authors: STRING; a_title: STRING; a_awarding_installation: STRING; a_award_exact_wording: STRING; a_awarding_date: STRING)
		require
			a_authors /= Void
			a_title /= Void
			a_awarding_installation /= Void
			a_award_exact_wording /= Void
			a_awarding_date /= Void
		do
			authors := a_authors
			title := a_title
			awarding_installation := a_awarding_installation
			award_exact_wording := a_award_exact_wording
			awarding_date := a_awarding_date
		ensure
			authors.same_string (a_authors)
			title.same_string (a_title)
			awarding_installation.same_string (a_awarding_installation)
			award_exact_wording.same_string (a_award_exact_wording)
			awarding_date.same_string (a_awarding_date)
		end

	authors: STRING

	title: STRING

	awarding_installation: STRING

	award_exact_wording: STRING

	awarding_date: STRING

end
