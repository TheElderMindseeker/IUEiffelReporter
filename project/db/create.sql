CREATE TABLE reports (
	report_id INTEGER,
	unit_name TEXT,
	head_name TEXT,
	rep_start REAL,
	rep_end REAL,
	PRIMARY KEY (report_id)
);

CREATE TABLE courses (
	course_id INTEGER,
	report_id INTEGER,
	course_name TEXT,
	semester TEXT,
	edu_level TEXT,
	num_students INTEGER,
	PRIMARY KEY (course_id),
	FOREIGN KEY (report_id) REFERENCES reports(report_id)
    ON DELETE CASCADE
);

CREATE TABLE examinations (
	exam_id INTEGER,
	course_id INTEGER,
	report_id INTEGER,
	exam_kind TEXT,
	num_students INTEGER,
	PRIMARY KEY (exam_id),
	FOREIGN KEY (course_id) REFERENCES courses(course_id)
    ON DELETE CASCADE,
	FOREIGN KEY (report_id) REFERENCES reports(report_id)
    ON DELETE CASCADE
);

CREATE TABLE supervised_students (
	student_id INTEGER,
	report_id INTEGER,
	student_name TEXT,
	nature_of_work TEXT,
	PRIMARY KEY (student_id),
	FOREIGN KEY (report_id) REFERENCES reports(report_id)
    ON DELETE CASCADE
);

CREATE TABLE student_reports (
	stud_rep_id INTEGER,
	report_id INTEGER,
	student_name TEXT,
	title TEXT,
	publication_plans TEXT,
	PRIMARY KEY (stud_rep_id),
	FOREIGN KEY (report_id) REFERENCES reports(report_id)
    ON DELETE CASCADE
);

CREATE TABLE completed_phd (
  thesis_id INTEGER,
  report_id INTEGER,
  student_name TEXT,
  degree TEXT,
  supervisor_name TEXT,
  other_committee_members TEXT,
  degree_granting_installation TEXT,
  dissertation_title TEXT,
  PRIMARY KEY (thesis_id),
  FOREIGN KEY (report_id) REFERENCES reports(report_id)
    ON DELETE CASCADE
);

CREATE TABLE grants (
  grant_id INTEGER,
  report_id INTEGER,
  project_title TEXT,
  granting_agency TEXT,
  start_date REAL,
  end_date REAL,
  is_continuation TEXT,
  amount INTEGER,
  PRIMARY KEY (grant_id),
  FOREIGN KEY (report_id) REFERENCES reports(report_id)
    ON DELETE CASCADE
);

CREATE TABLE research_projects (
  research_id INTEGER,
  report_id INTEGER,
  project_title TEXT,
  iu_personnel_involved TEXT,
  external_personnel_involved TEXT,
  start_date REAL,
  expected_end_date REAL,
  financial_sources TEXT,
  PRIMARY KEY (research_id),
  FOREIGN KEY (report_id) REFERENCES reports(report_id)
    ON DELETE CASCADE
);

CREATE TABLE research_collaborations (
  research_collaboration_id INTEGER,
  report_id INTEGER,
  installation_country TEXT,
  installation_name TEXT,
  installation_department TEXT,
  principal_contact_name TEXT,
  contacts TEXT,
  PRIMARY KEY (research_collaboration_id),
  FOREIGN KEY (report_id) REFERENCES reports(report_id)
    ON DELETE CASCADE
);

CREATE TABLE publications (
  publication_id INTEGER,
  report_id INTEGER,
  publication_name TEXT,
  PRIMARY KEY (publication_id),
  FOREIGN KEY (report_id) REFERENCES reports(report_id)
    ON DELETE CASCADE
);

CREATE TABLE patents_and_ip (
  patent_id INTEGER,
  report_id INTEGER,
  type TEXT,
  patent_title TEXT,
  patent_office_country TEXT,
  PRIMARY KEY (patent_id),
  FOREIGN KEY (report_id) REFERENCES reports(report_id)
    ON DELETE CASCADE
);

CREATE TABLE best_paper_awards (
  award_id INTEGER,
  report_id INTEGER,
  authors TEXT,
  title TEXT,
  awarding_installation TEXT,
  award_exact_wording TEXT,
  awarding_date REAL,
  PRIMARY KEY (award_id),
  FOREIGN KEY (report_id) REFERENCES reports(report_id)
    ON DELETE CASCADE
);

CREATE TABLE prizes (
  prize_id INTEGER,
  report_id INTEGER,
  recipient_name TEXT,
  prize_name TEXT,
  granting_installation TEXT,
  prizing_date REAL,
  PRIMARY KEY (prize_id),
  FOREIGN KEY (report_id) REFERENCES reports(report_id)
    ON DELETE CASCADE
);

CREATE TABLE industry_collaborations (
  industry_collaboration_id INTEGER,
  report_id INTEGER,
  company TEXT,
  nature_of_collaboration TEXT,
  PRIMARY KEY (industry_collaboration_id),
  FOREIGN KEY (report_id) REFERENCES reports(report_id)
    ON DELETE CASCADE
);

CREATE TABLE relevant_info (
  relevant_info_id INTEGER,
  report_id INTEGER,
  info TEXT,
  PRIMARY KEY (relevant_info_id),
  FOREIGN KEY (report_id) REFERENCES reports(report_id)
    ON DELETE CASCADE
);
