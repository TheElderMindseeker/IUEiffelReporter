note
	description: "This class is additional class for creating template. It contains attributes only"
	author: "Niyaz Ginatullin"
	date: "10.04.2017"
	revision: "1.0"

class
	PROJECT

create
	make

feature

	make (a_project_title: STRING; a_iu_personnel_involved: STRING; a_external_personnel_involved: STRING; a_start_date: STRING; a_expected_end_date: STRING; a_financial_sources: STRING)
			-- creates report about some unit, that contains a lot general information abut this report
		require
			a_project_title /= Void
			a_iu_personnel_involved /= Void
			a_external_personnel_involved /= Void
			a_start_date /= Void
			a_expected_end_date /= Void
		do
			project_title := a_project_title
			iu_personnel_involved := a_iu_personnel_involved
			external_personnel_involved := a_external_personnel_involved
			start_date := a_start_date
			expected_end_date := a_expected_end_date
			financial_sources := a_financial_sources
		ensure
			project_title.same_string (a_project_title)
			iu_personnel_involved.same_string (a_iu_personnel_involved)
			external_personnel_involved.same_string (a_external_personnel_involved)
			start_date.same_string (a_start_date)
			expected_end_date.same_string (a_expected_end_date)
			financial_sources.same_string (a_financial_sources)
		end

	project_title: STRING

	iu_personnel_involved: STRING

	external_personnel_involved: STRING

	start_date: STRING

	expected_end_date: STRING

	financial_sources: STRING

end
