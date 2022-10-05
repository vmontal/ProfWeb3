--USE MSSQL121445

declare @cmd varchar(4000)
declare cmds cursor for 
SELECT 'DROP PROCEDURE ' + SPECIFIC_NAME AS query FROM information_schema.routines WHERE SPECIFIC_NAME LIKE 'pf_%' OR SPECIFIC_NAME LIKE 'adm%'

open cmds
	while 1=1
		begin
			fetch cmds into @cmd
			if @@fetch_status != 0 break
			exec(@cmd)
		end
close cmds;

deallocate cmds