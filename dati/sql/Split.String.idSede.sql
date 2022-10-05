declare
@primo varchar(10) = '125',
@secondo int = 3,
@lenString int,
@vettore varchar(20) = '',
@i int = 1,
@separa varchar(1) = ','

SET @lenString = LEN(@primo)

while @i <= @lenString
	begin
		SET @vettore = @vettore +  substring(@primo, @i, 1) + @separa
		SET @i = @i +1
		--set @separa = ','
	end

print @vettore

if @secondo IN (select value from string_split(@vettore, ','))
	begin
		print 'vero'
	end
else
	begin
		print 'falso'
	end

