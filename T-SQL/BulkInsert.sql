USE airclic
GO

SELECT	*
FROM	GPS_Geofence_InsertTest1

BULK INSERT GPS_Geofence_InsertTest1
FROM 'C:\Documents and Settings\dtc1611\Desktop\GPS\GeoRefInsert-6.15.11.txt'

WITH(
FIRSTROW = 2,
FIELDTERMINATOR = '\t',
MAXERRORS = 9999999)

INSERT INTO [HERTZ836\DEVL].[airclic].[dbo].[GPS_Geofence_Ref]
           ([Ic]
           ,[Geofence_ID]
           ,[Geofence_Name]
           ,[Geofence_Type]
           ,[Geofence_Desc]
           ,[Geofence_Shape]
           ,[Geofence_LT1_TLLAT]
           ,[Geofence_LN1_TLLON]
           ,[Geofence_LT2]
           ,[Geofence_LN2]
           ,[Geofence_LT3_BRLAT]
           ,[Geofence_LN3_BRLON]
           ,[Geofence_LT4]
           ,[Geofence_LN4]
           ,[Geofence_LT5]
           ,[Geofence_LN5]
           ,[Geofence_LT6]
           ,[Geofence_LN6]
           ,[Geofence_LT7]
           ,[Geofence_LN7]
           ,[dtAdded]
           ,[IC_Assigned_Div])
    SELECT [Ic]
      ,[Geofence_ID]
      ,[Geofence_Name]
      ,[Geofence_Type]
      ,[Geofence_Desc]
      ,[Geofence_Shape]
      ,[Geofence_LT1_TLLAT]
      ,[Geofence_LN1_TLLON]
      ,[Geofence_LT2]
      ,[Geofence_LN2]
      ,[Geofence_LT3_BRLAT]
      ,[Geofence_LN3_BRLON]
      ,[Geofence_LT4]
      ,[Geofence_LN4]
      ,[Geofence_LT5]
      ,[Geofence_LN5]
      ,[Geofence_LT6]
      ,[Geofence_LN6]
      ,[Geofence_LT7]
      ,[Geofence_LN7]
      ,[dtAdded]
      ,[IC_Assigned_Div]
  FROM GPS_Geofence_InsertTest1