USE AIRCLIC
go

--create temp table with a list of IMEIs for the cursor. You can modify this query to get your list of IMEIs

select B.DeviceIMEI,B.DeviceModel
into #temp
from [HERTZ836\DEVL].[airclic].[dbo].[GPS_Device_Ref] B
where B.DeviceIMEI NOT IN (select A.UnitID from [HERTZ836\DEVL].[airclic].[dbo].[GPS_Dumpdata] A)
	--AND B.DeviceModel LIKE '%4500%' 
order by B.DeviceModel desc


DECLARE	@currentIMEI VARCHAR(15)	--variable which holds the current IMEI value of the cursor

DECLARE cursor2 CURSOR FOR			--this cursor must be created from some list of IMEIs. I created a temp table called
SELECT	DeviceIMEI					--#temp, for which the query is up above.
FROM	#temp					

OPEN	cursor2

FETCH NEXT FROM cursor2 INTO @currentIMEI

WHILE @@FETCH_STATUS = 0
BEGIN
	EXEC sp_insert_into_dumpdata_4500 @currentIMEI	--run the SP for each IMEI value in the cursor
	FETCH NEXT FROM cursor2 INTO @currentIMEI
END

CLOSE		cursor2
DEALLOCATE	cursor2

DROP TABLE #temp