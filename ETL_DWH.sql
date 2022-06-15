
/******-- https://www.youtube.com/watch?v=urLBGp3_3PY  ******/
/****** CREATE  Load_Dim_IP   ******/
-- Load table Dim_IP
USE [FactlessFactDW]
GO

-- Load table Dim_IP
CREATE OR ALTER PROCEDURE [dbo].[Load_Dim_IP]
AS

SET ANSI_WARNINGS OFF;

DECLARE @rowcountinsert INT;

BEGIN
	BEGIN TRANSACTION
		
	BEGIN TRY
	INSERT INTO Dim_IP (IPName)

	SELECT DISTINCT L.IPName
	FROM VW_LOG L
	WHERE 1=1
	AND NOT EXISTS (SELECT 1
					FROM Dim_IP D
					WHERE D.IPNAME = L.IPNAME --Check for new IP addresses by name
					)
	
	SET @rowcountinsert = @@ROWCOUNT;
	
	END TRY
	
	BEGIN CATCH  --Rollback if error occurs in the TRANSACTION, select Exception handling items...
    SELECT
        --ERROR_NUMBER() AS ErrorNumber  
        --,ERROR_SEVERITY() AS ErrorSeverity  
        --,ERROR_STATE() AS ErrorState  
        ERROR_PROCEDURE() AS ErrorProcedure  
        ,ERROR_LINE() AS ErrorLine  
        ,ERROR_MESSAGE() AS ErrorMessage;
	
	IF @@TRANCOUNT > 0  --check if there's an open transaction then ROLLBACK
        ROLLBACK TRANSACTION;
		
	/****** Write error to log   ******/
	INSERT INTO dbo.DWH_LOG (LOGDATE, PROCEDURENAME, INSERTED, UPDATED, ERRORLINE, ERRORMESSAGE)
	VALUES(GETDATE(), ERROR_PROCEDURE(), 0, 0, ERROR_LINE(),  SUBSTRING(ERROR_MESSAGE(), 1, 199)) --SUBSTRING: Maybe the err message is too long..
	END CATCH; --Rollback if error occurs
	
	IF @@TRANCOUNT > 0  --check if there's an open transaction then COMMIT
		COMMIT TRANSACTION;

	/****** Write transaction to log   ******/	
	INSERT INTO dbo.DWH_LOG (LOGDATE, PROCEDURENAME, INSERTED, UPDATED, ERRORLINE, ERRORMESSAGE)
	VALUES(GETDATE(), 'Load_Dim_IP', @rowcountinsert, 0, NULL, NULL);
	
END;
GO

PRINT 'PROCEDURE Load_Dim_IP Created'

/****** CREATE  Load_Dim_SOAP   ******/
-- Load table Dim_SOAP
CREATE OR ALTER PROCEDURE [dbo].[Load_Dim_SOAP]
AS
SET ANSI_WARNINGS OFF;

DECLARE @rowcountinsert INT;

BEGIN

	BEGIN TRANSACTION
		
	BEGIN TRY
	INSERT INTO Dim_SOAP (SOAP)

	SELECT DISTINCT L.SOAP
	FROM VW_LOG L
	WHERE 1=1
	AND NOT EXISTS (SELECT 1
					FROM Dim_SOAP D
					WHERE D.SOAP = L.SOAP --Check for new SOAP
					)
	
	SET @rowcountinsert = @@ROWCOUNT;
	
	END TRY
	
	BEGIN CATCH  --Rollback if error occurs in the TRANSACTION, select Exception handling items...
    SELECT
        --ERROR_NUMBER() AS ErrorNumber  
        --,ERROR_SEVERITY() AS ErrorSeverity  
        --,ERROR_STATE() AS ErrorState  
        ERROR_PROCEDURE() AS ErrorProcedure  
        ,ERROR_LINE() AS ErrorLine  
        ,ERROR_MESSAGE() AS ErrorMessage;
	
	IF @@TRANCOUNT > 0  --check if there's an open transaction then ROLLBACK
        ROLLBACK TRANSACTION;
		
	/****** Write error to log   ******/
	INSERT INTO dbo.DWH_LOG (LOGDATE, PROCEDURENAME, INSERTED, UPDATED, ERRORLINE, ERRORMESSAGE)
	VALUES(GETDATE(), ERROR_PROCEDURE(), 0, 0, ERROR_LINE(),  SUBSTRING(ERROR_MESSAGE(), 1, 199)) --SUBSTRING: Maybe the err message is too long..
	END CATCH; --Rollback if error occurs
	
	IF @@TRANCOUNT > 0  --check if there's an open transaction then COMMIT
		COMMIT TRANSACTION;

	/****** Write transaction to log   ******/	
	INSERT INTO dbo.DWH_LOG (LOGDATE, PROCEDURENAME, INSERTED, UPDATED, ERRORLINE, ERRORMESSAGE)
	VALUES(GETDATE(), 'Load_Dim_SOAP', @rowcountinsert, 0, NULL, NULL);
	
END;
GO

PRINT 'PROCEDURE Load_Dim_SOAP Created'

/****** CREATE  Load_Dim_BN   ******/
-- Load table Load_Dim_BN
CREATE OR ALTER   PROCEDURE [dbo].[Load_Dim_BN]
AS
SET ANSI_WARNINGS OFF;

DECLARE @rowcountinsert INT;
DECLARE @rowcountupdate INT;

BEGIN

	BEGIN TRANSACTION
		
	BEGIN TRY

	INSERT INTO Dim_BN (BNNAME, MARKTPARTY)

	SELECT DISTINCT L.BN_NUMBER, L.MARKTPARTY
	FROM VW_LOG L
	WHERE 1=1
	AND NOT EXISTS (SELECT 1
					FROM Dim_BN D
					WHERE D.BNNAME = L.BN_NUMBER --Check for new BN numbers by name
					)

	SET @rowcountinsert = @@ROWCOUNT;
	
	UPDATE [dbo].[Dim_BN]
	SET Dim_BN.MARKTPARTY = VW.MARKTPARTY
	,	Dim_BN.UPDATEON = GETDATE() --New date
	FROM Dim_BN
	JOIN (	SELECT DISTINCT BN_NUMBER, MARKTPARTY FROM [FactlessFactDW].[dbo].[VW_LOG] 
		 ) VW
			ON Dim_BN.BNNAME = VW.BN_NUMBER
			AND Dim_BN.MARKTPARTY <> VW.MARKTPARTY --Update MARKTPARTY if this has been changed
		 
	SET @rowcountupdate = @@ROWCOUNT;
	
	END TRY

	BEGIN CATCH  --Rollback if error occurs in the TRANSACTION, select Exception handling items...
    SELECT   
        --ERROR_NUMBER() AS ErrorNumber  
        --,ERROR_SEVERITY() AS ErrorSeverity  
        --,ERROR_STATE() AS ErrorState  
        ERROR_PROCEDURE() AS ErrorProcedure  
        ,ERROR_LINE() AS ErrorLine  
        ,ERROR_MESSAGE() AS ErrorMessage;  
  
    IF @@TRANCOUNT > 0  --check if there's an open transaction then ROLLBACK
        ROLLBACK TRANSACTION;
		
	/****** Write error to log   ******/
	INSERT INTO dbo.DWH_LOG (LOGDATE, PROCEDURENAME, INSERTED, UPDATED, ERRORLINE, ERRORMESSAGE)
	VALUES(GETDATE(), ERROR_PROCEDURE(), 0, 0, ERROR_LINE(),  SUBSTRING(ERROR_MESSAGE(), 1, 199)) --SUBSTRING: Maybe the err message is too long..
	END CATCH; --Rollback if error occurs

	IF @@TRANCOUNT > 0  --check if there's an open transaction then COMMIT
		COMMIT TRANSACTION;

	/****** Write transaction to log   ******/	
	INSERT INTO dbo.DWH_LOG (LOGDATE, PROCEDURENAME, INSERTED, UPDATED, ERRORLINE, ERRORMESSAGE)
	VALUES(GETDATE(), 'Load_Dim_BN', @rowcountinsert, @rowcountupdate, NULL, NULL);
	
END;
GO

PRINT 'PROCEDURE Load_Dim_BN Created'

/****** CREATE  Load_Fact   ******/
-- Load table dbo.Fact_LOG
CREATE OR ALTER PROCEDURE dbo.Load_Fact
AS

SET ANSI_WARNINGS OFF;

DECLARE @rowcount INT;
DECLARE @lastloaddate datetime;
DECLARE @lastlogdate datetime;

BEGIN

	BEGIN TRANSACTION;

	SET @lastloaddate = (SELECT LAST_LOAD_DATE FROM FactlessFactDW.dbo.LAST_LOAD);
	SET @lastlogdate = (SELECT MAX(DATES) FROM [dbo].[VW_LOG]);

	BEGIN TRY	
	/****** Drop FK's   ******/
	ALTER TABLE Fact_LOG
	DROP CONSTRAINT IF EXISTS FK_DimIP;

	ALTER TABLE Fact_LOG
	DROP CONSTRAINT IF EXISTS FK_DimBN;

	ALTER TABLE Fact_LOG
	DROP CONSTRAINT IF EXISTS FK_DimSOAP;

	ALTER TABLE Fact_LOG
	DROP CONSTRAINT IF EXISTS FK_DimDate; 	

	/****** Insert rows into fact table   ******/
	INSERT INTO dbo.Fact_LOG (IPDimKey, BNDimKey, SOAPKey, DateKey) 
	SELECT	IPDimKey
			, Dim_BN.BNDimKey
			, COALESCE(Dim_SOAP.SOAPKey, 0) AS SOAPKey
			, Dim_Date.DateKey
	FROM [dbo].[VW_LOG] L --View log met alle data in Staging
	LEFT JOIN FactlessFactDW.dbo.Dim_IP IP
	ON IP.IPNAME = L.IPNAME
	LEFT JOIN FactlessFactDW.dbo.Dim_BN
		ON Dim_BN.BNNAME = L.BN_NUMBER
	LEFT JOIN FactlessFactDW.dbo.Dim_SOAP
		ON Dim_SOAP.SOAP = L.SOAP
	LEFT JOIN FactlessFactDW.dbo.Dim_Date
		ON Dim_Date.Date = CONVERT(date,  L.DATES ) --Make date from datetime

	SET @rowcount = @@ROWCOUNT;
	PRINT CONCAT('Rowcount Select: ',@rowcount)
		
	IF @rowcount = 0
		PRINT 'No rows inserted'
	ELSE
		PRINT 'Rows inserted...'

	/****** Create FK's   ******/
	ALTER TABLE Fact_LOG
	  ADD CONSTRAINT FK_DimIP FOREIGN KEY (IPDimKey) REFERENCES dbo.Dim_IP (IPDimKey);

	ALTER TABLE Fact_LOG
	  ADD CONSTRAINT FK_DimBN FOREIGN KEY (BNDimKey) REFERENCES Dim_BN (BNDimKey);

	ALTER TABLE Fact_LOG
	  ADD CONSTRAINT FK_DimSOAP FOREIGN KEY (SOAPKey) REFERENCES Dim_SOAP (SOAPKey);

	ALTER TABLE Fact_LOG
	  ADD CONSTRAINT FK_DimDate FOREIGN KEY (DateKey) REFERENCES Dim_Date (DateKey);
	END TRY ------------
	
	BEGIN CATCH  --Rollback if error occurs in the TRANSACTION, select Exception handling items...
    SELECT   
        --ERROR_NUMBER() AS ErrorNumber  
        --,ERROR_SEVERITY() AS ErrorSeverity  
        --,ERROR_STATE() AS ErrorState  
        ERROR_PROCEDURE() AS ErrorProcedure  
        ,ERROR_LINE() AS ErrorLine  
        ,ERROR_MESSAGE() AS ErrorMessage;  
  
    IF @@TRANCOUNT > 0  --check if there's an open transaction then ROLLBACK
        ROLLBACK TRANSACTION;
		
	/****** Write error to log   ******/
	INSERT INTO dbo.DWH_LOG (LOGDATE, PROCEDURENAME, INSERTED, UPDATED, ERRORLINE, ERRORMESSAGE)
	VALUES(GETDATE(), ERROR_PROCEDURE(), 0, 0, ERROR_LINE(),  SUBSTRING(ERROR_MESSAGE(), 1, 199)) --SUBSTRING: Maybe the err message is too long..
	END CATCH; --Rollback if error occurs
	
	IF @@TRANCOUNT > 0  --check if there's an open transaction then COMMIT
		COMMIT TRANSACTION;
	
	/****** Write transaction to log   ******/	
	INSERT INTO dbo.DWH_LOG (LOGDATE, PROCEDURENAME, INSERTED, UPDATED, ERRORLINE, ERRORMESSAGE)
	VALUES(GETDATE(), 'Load_Fact', @rowcount, 0, NULL, NULL)
	PRINT 'Rows inserted DWH_LOG...'
	
	/****** Write last log date time of loaded log   ******/
	IF @lastlogdate IS NOT NULL
		UPDATE dbo.LAST_LOAD
		SET LAST_LOAD_DATE = @lastlogdate
		PRINT CONCAT('Update LAST_LOAD_DATE: ',@lastlogdate);
END
GO

PRINT 'PROCEDURE Load_Fact Created'