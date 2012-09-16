USE airclic
GO

CREATE TABLE	oCustomers(
		Order_Num	int			NOT NULL	IDENTITY(100,1),
		Customers	varchar(30)	NOT NULL)
		
DROP TABLE iCustomers

INSERT INTO iCustomers(Customers)
	VALUES	('Devin');
	
SELECT	*
FROM	iCustomers 

INSERT INTO iCustomers(Customers)
	VALUES	('Aaron');

DROP TRIGGER	tr_iCustomers

CREATE TRIGGER	tr_iCustomers
ON				iCustomers
AFTER INSERT
AS
BEGIN
INSERT	INTO	oCustomers(Customers)
SELECT			Customers
FROM			INSERTED
END;

DECLARE	@number int;

SET @number=2;

SELECT @number AS Variable;