USE AIRCLIC
GO

SELECT		DISTINCT Devl_Table_Name
FROM		Devl_vs_Prod2
WHERE		Prod_Table_Name IS NULL
ORDER BY	Devl_Table_Name

SELECT		DISTINCT Devl_Table_Name
FROM		Devl_vs_Prod2
WHERE		Prod_Table_Name IS NULL AND
			NOT Devl_Table_Name IN (	'GPS_Detail_bkup','GPS_Device_Ref_bkup',
										'GPS_Dumpdata_bkup','GPS_Dumpdata_bkup2',
										'GPS_IC_Current_Status_Fri',
										'GPS_IC_Current_Status_History',
										'GPS_IC_Current_Status_Mon',
										'GPS_IC_Current_Status_Sat',
										'GPS_IC_Current_Status_Sun',
										'GPS_IC_Current_Status_test',
										'GPS_IC_Current_Status_Thu',
										'GPS_IC_Current_Status_Tue',
										'GPS_IC_Current_Status_Wed',
										'GPS_IC_Daily_Status_bkup',
										'GPS_IC_Daily_Status_test',
										'HERTZ_backup',
										'iTrip2','iTrip3','oACUserTest',
										'oEmpSummary_bkup',
										'oEmpSummary_test',
										'oEmpSummary1',
										'oEmpSummarytest',
										'test','test1','test2','test3')
ORDER BY	Devl_Table_Name

CREATE VIEW Condensed_Devl_vs_Prod AS
SELECT		DISTINCT Devl_Table_Name
FROM		Devl_vs_Prod2
WHERE		Prod_Table_Name IS NULL AND
			NOT Devl_Table_Name IN (	'GPS_Detail_bkup','GPS_Device_Ref_bkup',
										'GPS_Dumpdata_bkup','GPS_Dumpdata_bkup2',
										'GPS_IC_Current_Status_Fri',
										'GPS_IC_Current_Status_History',
										'GPS_IC_Current_Status_Mon',
										'GPS_IC_Current_Status_Sat',
										'GPS_IC_Current_Status_Sun',
										'GPS_IC_Current_Status_test',
										'GPS_IC_Current_Status_Thu',
										'GPS_IC_Current_Status_Tue',
										'GPS_IC_Current_Status_Wed',
										'GPS_IC_Daily_Status_bkup',
										'GPS_IC_Daily_Status_test',
										'HERTZ_backup',
										'iTrip2','iTrip3','oACUserTest',
										'oEmpSummary_bkup',
										'oEmpSummary_test',
										'oEmpSummary1',
										'oEmpSummarytest',
										'test','test1','test2','test3')

SELECT		*
FROM		Condensed_Devl_vs_Prod
ORDER BY	Devl_Table_Name

SELECT		*	
FROM		PK_Test