--USE MSSql121445

declare @cmd varchar(4000)
declare cmds cursor for 

SELECT 'DROP VIEW ' + TABLE_NAME AS query FROM information_schema.VIEWS WHERE TABLE_NAME LIKE 'pf_%' OR TABLE_NAME LIKE 'adm%'

open cmds
while 1=1
begin
    fetch cmds into @cmd
    if @@fetch_status != 0 break
    exec(@cmd)
end
close cmds;
deallocate cmds