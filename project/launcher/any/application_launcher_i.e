note
	description: "[
			Specific application launcher

			DO NOT EDIT THIS CLASS

			you can customize APPLICATION_LAUNCHER
		]"
	date: "$Date: 2016-06-29 05:58:45 -0700 (Wed, 29 Jun 2016) $"
	revision: "$Revision: 98966 $"

deferred class
	APPLICATION_LAUNCHER_I [G -> WSF_EXECUTION create make end]

inherit
	SHARED_EXECUTION_ENVIRONMENT	

feature -- Execution

	launch (opts: detachable WSF_SERVICE_LAUNCHER_OPTIONS)
			-- Launch Web Server Application using optionals `opts'.
		local
			launcher: WSF_SERVICE_LAUNCHER [G]
		do
			if not attached launcher_id as l_id then


					-- Choose a default -> standalone
				create {WSF_STANDALONE_SERVICE_LAUNCHER [G]} launcher.make_and_launch (opts)

			elseif is_nino_launcher_id (l_id) then
				create {WSF_STANDALONE_SERVICE_LAUNCHER [G]} launcher.make_and_launch (opts)




			else
				io.error.put_string ("Application launcher not found!%N")
				(create {EXCEPTIONS}).die (-1)
			end
		end

	launcher_id: detachable READABLE_STRING_GENERAL
			-- Launcher id based on the executable extension name if any.
			-- This can be redefine to customize for your application.
			--| ex: nino, cgi, libfcgi or Void.
		do
			if attached (create {PATH}.make_from_string (execution_environment.arguments.command_name)).extension as ext then
				Result := ext
			end
		end

feature -- Status report		


	is_nino_launcher_id (a_id: READABLE_STRING_GENERAL): BOOLEAN
		do
			Result := a_id.is_case_insensitive_equal ("standalone")
		end







end

