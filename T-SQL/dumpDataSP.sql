CREATE PROCEDURE sp_insert_into_dumpdata_4500 
					@IMEI varchar(15)	AS

--First, inserts a majority of the event numbers that have the same row syntax

DECLARE @currentEvent VARCHAR(10)

SELECT	EventNbr
INTO	#temp
FROM	[HERTZ836\DEVL].[airclic].[dbo].[GPS_Dumpdata]
WHERE	UnitID = '354660044523168' AND EventNbr NOT IN ('6004','4006','6015')

DECLARE cursor1 CURSOR FOR
SELECT *
FROM #temp

open cursor1

FETCH NEXT FROM cursor1 INTO @currentEvent

WHILE @@FETCH_STATUS = 0
BEGIN
INSERT	INTO [HERTZ836\DEVL].[airclic].[dbo].[GPS_Dumpdata]
           ([UnitID]
           ,[EventNbr]
           ,[Syntax]
           ,[xmlmap]
           ,[columnmap])
		VALUES
           (
           @IMEI,
           @currentEvent,
           'UnitID,EventNbr,DOT,TOT,GeoLat,GeoLong,GeoAlt,Speed,Heading,SatsUsed,HDOP_GPS_accuracy,BatteryVolt,GSM_Signal,Miles_Since,GPSstat,Backup_BatterryVolt,PowerUp_ResetMode,IC',
           '<UnitID>{0}</UnitID><EventNbr>{1}</EventNbr><DOT>{2}</DOT><TOT>{3}</TOT><GeoLat>{4}</GeoLat><GeoLong>{5}</GeoLong><GeoAlt>{6}</GeoAlt><Speed>{7}</Speed><Heading>{8}</Heading><SatsUsed>{9}</SatsUsed><HDOP_GPS_accuracy>{10}</HDOP_GPS_accuracy><BatteryVolt>{11}</BatteryVolt><GSM_Signal>{12}</GSM_Signal><Miles_Since>{13}</Miles_Since><GPSstat>{14}</GPSstat><Backup_BatterryVolt>{15}</Backup_BatterryVolt><PowerUp_ResetMode>{16}</PowerUp_ResetMode><IC>{17}</IC>',
           'UnitID varchar(15),EventNbr varchar(20),DOT varchar(20),TOT varchar(20),GeoLat float,GeoLong float,GeoAlt float,Speed decimal(5, 2),Heading decimal(7, 1),SatsUsed smallint ,HDOP_GPS_accuracy decimal(7, 1) ,BatteryVolt decimal(7, 1) ,GSM_Signal smallint, Miles_Since decimal(8, 2), GPSstat varchar(5), Backup_BatterryVolt decimal(7, 1), PowerUp_ResetMode decimal(7, 1),IC varchar(13)'
           )

	FETCH NEXT FROM cursor1 INTO @currentEvent
END

CLOSE		cursor1
DEALLOCATE	cursor1

DROP TABLE #temp

--Inserts rows for event # 6004

INSERT INTO [HERTZ836\DEVL].[airclic].[dbo].[GPS_Dumpdata]
           ([UnitID]
           ,[EventNbr]
           ,[Syntax]
           ,[xmlmap]
           ,[columnmap])
     VALUES
           (
           @IMEI,
           6004,
           'UnitID,EventNbr,DOT,TOT,GeoLat,GeoLong,GeoAlt,Speed,Heading,SatsUsed,HDOP_GPS_accuracy,BatteryVolt,GSM_Signal,Miles_Since,GPSstat,Backup_BatterryVolt,PowerUp_ResetMode,GeofenceID,IC',
           '<UnitID>{0}</UnitID><EventNbr>{1}</EventNbr><DOT>{2}</DOT><TOT>{3}</TOT><GeoLat>{4}</GeoLat><GeoLong>{5}</GeoLong><GeoAlt>{6}</GeoAlt><Speed>{7}</Speed><Heading>{8}</Heading><SatsUsed>{9}</SatsUsed><HDOP_GPS_accuracy>{10}</HDOP_GPS_accuracy><BatteryVolt>{11}</BatteryVolt><GSM_Signal>{12}</GSM_Signal><Miles_Since>{13}</Miles_Since><GPSstat>{14}</GPSstat><Backup_BatterryVolt>{15}</Backup_BatterryVolt><PowerUp_ResetMode>{16}</PowerUp_ResetMode><GeofenceID>{17}</GeofenceID><IC>{18}</IC>',
           'UnitID varchar(15),EventNbr varchar(20),DOT varchar(20),TOT varchar(20),GeoLat float,GeoLong float,GeoAlt float,Speed decimal(5, 2),Heading decimal(7, 1),SatsUsed smallint ,HDOP_GPS_accuracy decimal(7, 1) ,BatteryVolt decimal(7, 1) ,GSM_Signal smallint, Miles_Since decimal(8, 2), GPSstat varchar(5), Backup_BatterryVolt decimal(7, 1), PowerUp_ResetMode decimal(7, 1),GeofenceID varchar(5),IC varchar(13)'
           )

--Inserts rows for event # 4006 & 6015
 INSERT INTO [HERTZ836\DEVL].[airclic].[dbo].[GPS_Dumpdata]
           ([UnitID]
           ,[EventNbr]
           ,[Syntax]
           ,[xmlmap]
           ,[columnmap])
     VALUES
           (
           @IMEI,
           4006,
           'UnitID,EventNbr,DOT,TOT,GeoLat,GeoLong,GeoAlt,Speed,Heading,SatsUsed,HDOP_GPS_accuracy,BatteryVolt,GSM_Signal,Miles_Since,GPSstat,Backup_BatterryVolt,PowerUp_ResetMode,FirmwareVersion,ProfileName,IC',
           '<UnitID>{0}</UnitID><EventNbr>{1}</EventNbr><DOT>{2}</DOT><TOT>{3}</TOT><GeoLat>{4}</GeoLat><GeoLong>{5}</GeoLong><GeoAlt>{6}</GeoAlt><Speed>{7}</Speed><Heading>{8}</Heading><SatsUsed>{9}</SatsUsed><HDOP_GPS_accuracy>{10}</HDOP_GPS_accuracy><BatteryVolt>{11}</BatteryVolt><GSM_Signal>{12}</GSM_Signal><Miles_Since>{13}</Miles_Since><GPSstat>{14}</GPSstat><Backup_BatterryVolt>{15}</Backup_BatterryVolt><PowerUp_ResetMode>{16}</PowerUp_ResetMode><FirmwareVersion>{17}</FirmwareVersion><ProfileName>{18}</ProfileName><IC>{19}</IC>',
           'UnitID varchar(15),EventNbr varchar(20),DOT varchar(20),TOT varchar(20),GeoLat float,GeoLong float,GeoAlt float,Speed decimal(5, 2),Heading decimal(7, 1),SatsUsed smallint ,HDOP_GPS_accuracy decimal(7, 1) ,BatteryVolt decimal(7, 1) ,GSM_Signal smallint, Miles_Since decimal(8, 2), GPSstat varchar(5), Backup_BatterryVolt decimal(7, 1), PowerUp_ResetMode decimal(7, 1),FirmwareVersion varchar(50),ProfileName varchar(50),IC varchar(13)'
           )
           
INSERT INTO [HERTZ836\DEVL].[airclic].[dbo].[GPS_Dumpdata]
           ([UnitID]
           ,[EventNbr]
           ,[Syntax]
           ,[xmlmap]
           ,[columnmap])
     VALUES
           (
           @IMEI,
           6015,
           'UnitID,EventNbr,DOT,TOT,GeoLat,GeoLong,GeoAlt,Speed,Heading,SatsUsed,HDOP_GPS_accuracy,BatteryVolt,GSM_Signal,Miles_Since,GPSstat,Backup_BatterryVolt,PowerUp_ResetMode,FirmwareVersion,ProfileName,IC',
           '<UnitID>{0}</UnitID><EventNbr>{1}</EventNbr><DOT>{2}</DOT><TOT>{3}</TOT><GeoLat>{4}</GeoLat><GeoLong>{5}</GeoLong><GeoAlt>{6}</GeoAlt><Speed>{7}</Speed><Heading>{8}</Heading><SatsUsed>{9}</SatsUsed><HDOP_GPS_accuracy>{10}</HDOP_GPS_accuracy><BatteryVolt>{11}</BatteryVolt><GSM_Signal>{12}</GSM_Signal><Miles_Since>{13}</Miles_Since><GPSstat>{14}</GPSstat><Backup_BatterryVolt>{15}</Backup_BatterryVolt><PowerUp_ResetMode>{16}</PowerUp_ResetMode><FirmwareVersion>{17}</FirmwareVersion><ProfileName>{18}</ProfileName><IC>{19}</IC>',
           'UnitID varchar(15),EventNbr varchar(20),DOT varchar(20),TOT varchar(20),GeoLat float,GeoLong float,GeoAlt float,Speed decimal(5, 2),Heading decimal(7, 1),SatsUsed smallint ,HDOP_GPS_accuracy decimal(7, 1) ,BatteryVolt decimal(7, 1) ,GSM_Signal smallint, Miles_Since decimal(8, 2), GPSstat varchar(5), Backup_BatterryVolt decimal(7, 1), PowerUp_ResetMode decimal(7, 1),FirmwareVersion varchar(50),ProfileName varchar(50),IC varchar(13)'
           )
GO
