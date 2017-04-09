--------------- Innopolis University Eiffel Reporter. User guide

The alias for Innopolis University Eiffel Reporter is IUEiffelReporter.

------- General Information

This system is intended to collect, store, analyze and manage the reports of the faculty of Innopolis University.
The system has two interfaces: user interface for faculty and administrative interface for administration of the university.
The main features of the system are simple one-page report submission via web interface with resubmission support,
intuitive report management including data analysis, editing and deletion.

------- Compile Guide

This guide is independent of the system you are using (it must work properly on Windows, Linux and Mac OS but it was only tested
on Linux and Windows).

The system is written in Eiffel programming language so for compilation it needs EiffelStudio IDE or equivalently Eiffel Compiler
used from console interface (recommended only for experienced users). To get EiffelStudio IDE, please, visit official Eiffel page
www.eiffel.com; the minimal supported version of EiffelStudio is 16.04;

--- General Project Structure

The IUEiffelReporter directory has the following structure:

./ # root IUEiffelReporter directory
  \
  |-- project/ # directory with main project source files for compilation. Attention: main project .ecf file is situated here
  |
  \-- README.txt # the document you are currently reading

--- Compilation

Start EiffelStudio and open .ecf project file at IUEiffelReporter project/ directory. You can either open it with compile action
or compile it manually by pressing "Compile" button after the project loaded. For maximal performance you can finalize the project
(recommended only for experienced users).

--- Run preparation

Before the run of the application make sure the port 80 on your machine is free (not used by other applicaions like Apache).
IUEiffelReporter uses the port 80 for users' convenience but it will not work properly if the port is occupied.

--- Run

Press "Run" button to start the application. The application web interface is now available on localhost/; the user interface,
report form is availabale on localhost/form and administative interface is available on localhost/admin
