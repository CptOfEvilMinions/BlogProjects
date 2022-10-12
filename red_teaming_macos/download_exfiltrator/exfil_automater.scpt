get items for newItems added to Finder
	-- Get the name of the attached folder
	tell application "Finder"
		-- Define file extensions
		set file_extensions to {"word doc", "powerpoint", "spreadsheet"}

        -- Set the url of the server
		set theURL to "http://<server_ip_addr>:<server_port>/"

		-- Iterate over all new files in directory
		repeat with anItem in theNewItems

			-- Convert file obj to stirng
			set theFilename to anItem as string

			-- Convert macOS filepoath to POSIX style
			set theFilenamePOSIX to POSIX path of theFilename

			-- Iterate over all file extensions
			repeat with file_ext in file_extensions
				-- extract the file extension from file obj
				set temp to text -3 thru -1 of theFilenamePOSIX

				-- Check if there is a match for file extensions
				if ((temp as string) is equal to file_ext as string) then
					-- POST new file to server
					do shell script "curl -X POST --upload-file " & quoted form of theFilenamePOSIX & " " & quoted form of theURL
				end if
			end repeat

		end repeat
	end tell
end adding folder items to
