USE [FactlessFactDW]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

ALTER TABLE Fact_LOG
DROP CONSTRAINT IF EXISTS FK_DimIP;

ALTER TABLE Fact_LOG
DROP CONSTRAINT IF EXISTS FK_DimBN;

ALTER TABLE Fact_LOG
DROP CONSTRAINT IF EXISTS FK_DimSOAP;

ALTER TABLE Fact_LOG
DROP CONSTRAINT IF EXISTS FK_DimDate;

PRINT 'FKs dropped IF Exists!'

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SV_ATTRIBUTES]') AND type in (N'U'))
DROP TABLE [dbo].[SV_ATTRIBUTES]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SV_LOG]') AND type in (N'U'))
DROP TABLE [dbo].[SV_LOG]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Dim_IP]') AND type in (N'U'))
DROP TABLE [dbo].[Dim_IP]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Dim_BN]') AND type in (N'U'))
DROP TABLE [dbo].[Dim_BN]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Dim_SOAP]') AND type in (N'U'))
DROP TABLE [dbo].[Dim_SOAP]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Dim_Date]') AND type in (N'U'))
DROP TABLE [dbo].[Dim_Date]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Fact_Log]') AND type in (N'U'))
DROP TABLE [dbo].[Fact_Log]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[LAST_LOAD]') AND type in (N'U'))
DROP TABLE [dbo].[LAST_LOAD]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DWH_LOG]') AND type in (N'U'))
DROP TABLE [dbo].[DWH_LOG]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[VW_LOG]') AND type in (N'U'))
DROP VIEW [dbo].[VW_LOG]
GO

PRINT 'TABLES dropped!'

/****** CREATE  TABLE [dbo].[SV_ATTRIBUTES]   ******/
CREATE TABLE [dbo].[SV_ATTRIBUTES](
	[IPNAME] [nvarchar](50) NULL,
	[BN_NUMBER] [nvarchar](50) NULL,
	[SERVICENAME] [nvarchar](50) NULL,
	[URL_PATH] [nvarchar](50) NULL,
	[MARKTPARTY] [nvarchar](50) NULL
) ON [PRIMARY]
GO

INSERT INTO  [dbo].[SV_ATTRIBUTES] ([IPNAME],[BN_NUMBER],[SERVICENAME],[URL_PATH],[MARKTPARTY])
VALUES ('192.168.10.1', 'BS000001', 'ADC10000', '/web/web2/urlpath01', 'Marktparty01');

INSERT INTO  [dbo].[SV_ATTRIBUTES] ([IPNAME],[BN_NUMBER],[SERVICENAME],[URL_PATH],[MARKTPARTY])
VALUES ('192.168.11.1', 'BS000001', 'ADC10000', '/web/web2/urlpath02', 'Marktparty01');

INSERT INTO  [dbo].[SV_ATTRIBUTES] ([IPNAME],[BN_NUMBER],[SERVICENAME],[URL_PATH],[MARKTPARTY])
VALUES ('192.168.12.1', 'BS000001', 'ADC10000', '/web/web2/urlpath03', 'Marktparty01');

INSERT INTO  [dbo].[SV_ATTRIBUTES] ([IPNAME],[BN_NUMBER],[SERVICENAME],[URL_PATH],[MARKTPARTY])
VALUES ('192.168.20.1', 'BS000002', 'ADC10000', '/web/web2/urlpath21', 'Marktparty01');

INSERT INTO  [dbo].[SV_ATTRIBUTES] ([IPNAME],[BN_NUMBER],[SERVICENAME],[URL_PATH],[MARKTPARTY])
VALUES ('192.168.21.1', 'BS000002', 'ADC10000', '/web/web2/urlpath22', 'Marktparty01');

INSERT INTO  [dbo].[SV_ATTRIBUTES] ([IPNAME],[BN_NUMBER],[SERVICENAME],[URL_PATH],[MARKTPARTY])
VALUES ('192.168.22.1', 'BS000002', 'ADC10000', '/web/web2/urlpath23', 'Marktparty01');

INSERT INTO  [dbo].[SV_ATTRIBUTES] ([IPNAME],[BN_NUMBER],[SERVICENAME],[URL_PATH],[MARKTPARTY])
VALUES ('192.168.33.1', 'BS000003', 'ADC10003', '/web/web2/urlpath33', 'Marktparty03');

INSERT INTO  [dbo].[SV_ATTRIBUTES] ([IPNAME],[BN_NUMBER],[SERVICENAME],[URL_PATH],[MARKTPARTY])
VALUES ('192.168.44.1', 'BS000004', 'ADC10004', '/web/web2/urlpath44', 'Marktparty03');

GO

PRINT 'TABLE SV_ATTRIBUTES CREATED'

/****** CREATE  TABLE [dbo].[SV_LOG]   ******/
CREATE TABLE [dbo].[SV_LOG](
	[SNAME] [nvarchar](50) NOT NULL,
	[URL_PATH] [nvarchar](50) NOT NULL,
	[SOAP] [nvarchar](50) NULL,
	[DATES] DateTime2 NOT NULL
) ON [PRIMARY]
GO

INSERT INTO FactlessFactDW.dbo.SV_LOG([SNAME],[URL_PATH],[SOAP],[DATES])
VALUES ('ADC10000', '/web/web2/urlpath02', 'ReceiveRequest', '2022-01-01 12:00:01');

INSERT INTO FactlessFactDW.dbo.SV_LOG([SNAME],[URL_PATH],[SOAP],[DATES])
VALUES ('ADC10000', '/web/web2/urlpath02', 'ReceiveRequest', '2022-01-02 23:25:01');

INSERT INTO FactlessFactDW.dbo.SV_LOG([SNAME],[URL_PATH],[SOAP],[DATES])
VALUES ('ADC10000', '/web/web2/urlpath02', 'ReceiveRequest', '2022-01-03 23:25:01');

INSERT INTO FactlessFactDW.dbo.SV_LOG([SNAME],[URL_PATH],[SOAP],[DATES])
VALUES ('ADC10000', '/web/web2/urlpath02', 'ReceiveRequest', '2022-01-04 23:25:01');

INSERT INTO FactlessFactDW.dbo.SV_LOG([SNAME],[URL_PATH],[SOAP],[DATES])
VALUES ('ADC10000', '/web/web2/urlpath02', 'ReceiveRequest', '2022-01-05 23:25:01');

INSERT INTO FactlessFactDW.dbo.SV_LOG([SNAME],[URL_PATH],[SOAP],[DATES])
VALUES ('ADC10000', '/web/web2/urlpath02', 'ReceiveRequest', '2022-01-06 23:25:01');

INSERT INTO FactlessFactDW.dbo.SV_LOG([SNAME],[URL_PATH],[SOAP],[DATES])
VALUES ('ADC10000', '/web/web2/urlpath02', 'ReceiveRequest', '2022-01-07 23:25:01');

INSERT INTO FactlessFactDW.dbo.SV_LOG([SNAME],[URL_PATH],[SOAP],[DATES])
VALUES ('ADC10000', '/web/web2/urlpath02', 'ReceiveRequest', '2022-01-09 23:25:01');

INSERT INTO FactlessFactDW.dbo.SV_LOG([SNAME],[URL_PATH],[SOAP],[DATES])
VALUES ('ADC10000', '/web/web2/urlpath02', 'ReceiveRequest', '2022-01-10 23:25:01');

INSERT INTO FactlessFactDW.dbo.SV_LOG([SNAME],[URL_PATH],[SOAP],[DATES])
VALUES ('ADC10000', '/web/web2/urlpath02', 'ReceiveRequest', '2022-01-11 23:25:01');

INSERT INTO FactlessFactDW.dbo.SV_LOG([SNAME],[URL_PATH],[SOAP],[DATES])
VALUES ('ADC10000', '/web/web2/urlpath02', 'ReceiveRequest', '2022-01-12 23:25:01');

GO

PRINT 'TABLE SV_LOG Created'

/****** TBLES DWH *********************/
/****** Object:  Table [dbo].[Dim_IP]    Script Date: 10-6-2022 15:40:34 ******/
CREATE TABLE [dbo].[Dim_IP](
	[IPDimKey] [int] IDENTITY(1,1) NOT NULL,
	[IPNAME] [varchar](100) NULL,
	[CREATEON] [datetime2](7) NULL,
	[UPDATEON] [datetime2](7) NULL,
PRIMARY KEY CLUSTERED 
(
	[IPDimKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Dim_IP] ADD  DEFAULT (getdate()) FOR [CREATEON]
GO

ALTER TABLE [dbo].[Dim_IP] ADD  DEFAULT (getdate()) FOR [UPDATEON]
GO

PRINT 'TABLE Dim_IP Created'

/****** Object:  Table [dbo].[Dim_BN]    Script Date: 10-6-2022 11:00:59 ******/
CREATE TABLE [dbo].[Dim_BN](
	[BNDimKey] [int] IDENTITY(1,1) NOT NULL,
	[BNNAME] [varchar](100) NULL,
	[MARKTPARTY] [varchar](100) NULL,
	[CREATEON] [datetime2](3) NULL,
	[UPDATEON] [datetime2](3) NULL
PRIMARY KEY CLUSTERED 
(
	[BNDimKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Dim_BN] ADD  DEFAULT (getdate()) FOR [CREATEON]
GO

ALTER TABLE [dbo].[Dim_BN] ADD  DEFAULT (getdate()) FOR [UPDATEON]
GO

PRINT 'TABLE SV_LOG Created'

/****** Object:  Table [dbo].[Dim_SOAP]    Script Date: 10-6-2022 13:12:42 ******/
CREATE TABLE [dbo].[Dim_SOAP](
	[SOAPKey] [int] IDENTITY(1,1) NOT NULL,
	[SOAP] [varchar](100) NULL
PRIMARY KEY CLUSTERED 
(
	[SOAPKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

PRINT 'TABLE Dim_SOAP Created'

/****** Object:  Table [dbo].[Fact_Log]    Script Date: 10-6-2022 13:14:39 ******/
CREATE TABLE [dbo].[Fact_Log](
	[FactKey] [int] IDENTITY(1,1) NOT NULL,
	[IPDimKey] [int] NULL,
	[BNDimKey] [int] NULL,
	[SOAPKey] [int] NULL,
	[DateKey] [int] NULL
PRIMARY KEY CLUSTERED 
(
	[FactKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

PRINT 'TABLE Fact_Log Created'

/****** Create Dim_Date   ******/
CREATE TABLE [dbo].[Dim_Date] (
   [DateKey] [int] NOT NULL,
   [Date] [date] NOT NULL,
   [Day] [tinyint] NOT NULL,
   [Weekday] [tinyint] NOT NULL,
   [WeekDayName] [varchar](10) NOT NULL,
   [DayOfYear] [smallint] NOT NULL,
   [WeekOfMonth] [tinyint] NOT NULL,
   [WeekOfYear] [tinyint] NOT NULL,
   [Month] [tinyint] NOT NULL,
   [MonthName] [varchar](10) NOT NULL,
   [Quarter] [tinyint] NOT NULL,
   [QuarterName] [varchar](6) NOT NULL,
   [Year] [int] NOT NULL,
   [MMYYYY] [char](6) NOT NULL,
   [MonthYear] [char](7) NOT NULL
   PRIMARY KEY CLUSTERED ([DateKey] ASC)
   )

GO

/****** Fill Dim_Date   ******/
SET NOCOUNT ON

TRUNCATE TABLE DIM_Date

DECLARE @CurrentDate DATE = '2022-01-01' --ADD dates for DIM_Date
DECLARE @EndDate DATE = '2022-09-02'

WHILE @CurrentDate < @EndDate
BEGIN

   INSERT INTO [dbo].[Dim_Date] ( [DateKey]
								, [Date]
								, [Day]
								, [Weekday]
								, [WeekDayName]
								, [DayOfYear]
								, [WeekOfMonth] 
								, [WeekOfYear]
								, [Month]
								, [MonthName]
								, [Quarter]
								, [QuarterName]
								, [Year]
								, [MMYYYY]
								, [MonthYear] 
								)
   SELECT 
		DateKey = YEAR(@CurrentDate) * 10000 + MONTH(@CurrentDate) * 100 + DAY(@CurrentDate),
		[Date] = @CurrentDate,
		Day = DAY(@CurrentDate),
		Weekday = DATEPART(dw, @CurrentDate),
		WeekDayName = DATENAME(dw, @CurrentDate),
		DayOfYear= DATENAME(dy, @CurrentDate),
		WeekOfMonth = DATEPART(WEEK, @CurrentDate) - DATEPART(WEEK, DATEADD(MM, DATEDIFF(MM, 0, @CurrentDate), 0)) + 1,
		WeekOfYear = DATEPART(wk, @CurrentDate),
		Month = MONTH(@CurrentDate),
		MonthName = DATENAME(mm, @CurrentDate),
		Quarter = DATEPART(q, @CurrentDate),
		QuarterName = CASE 
			WHEN DATENAME(qq, @CurrentDate) = 1
            THEN 'First'
			WHEN DATENAME(qq, @CurrentDate) = 2
            THEN 'second'
			WHEN DATENAME(qq, @CurrentDate) = 3
            THEN 'third'
			WHEN DATENAME(qq, @CurrentDate) = 4
				THEN 'fourth'
			END,
		Year = YEAR(@CurrentDate),
		MMYYYY = RIGHT('0' + CAST(MONTH(@CurrentDate) AS VARCHAR(2)), 2) + CAST(YEAR(@CurrentDate) AS VARCHAR(4)),
		MonthYear = CAST(YEAR(@CurrentDate) AS VARCHAR(4)) + UPPER(LEFT(DATENAME(mm, @CurrentDate), 3))
	SET @CurrentDate = DATEADD(DD, 1, @CurrentDate)
END;

PRINT 'TABLE DIM_Date Created'

/****** Create load table  ******/
CREATE TABLE FactlessFactDW.dbo.LAST_LOAD(
	LAST_LOAD_DATE datetime2 --date and time of last log loaded
)
--Add the default
ALTER TABLE FactlessFactDW.dbo.LAST_LOAD  --What table
ADD CONSTRAINT [def_LAST_LOAD_DATE] --Give the constraint a name
    DEFAULT GETDATE() FOR LAST_LOAD_DATE; --default of what for which column

--Set to not allow NULL
ALTER TABLE FactlessFactDW.dbo.LAST_LOAD --What table
ALTER COLUMN LAST_LOAD_DATE datetime2 NOT NULL;  --altering what column and either NULL or NOT NULL

INSERT INTO FactlessFactDW.dbo.LAST_LOAD (LAST_LOAD_DATE)
VALUES('2022-01-01 00:15:50')

UPDATE FactlessFactDW.dbo.LAST_LOAD
SET LAST_LOAD_DATE = '2022-01-01 00:05:50'

PRINT 'TABLE LAST_LOAD Created'

 /****** Create log table  ******/
CREATE TABLE FactlessFactDW.dbo.DWH_LOG(
    LOGKEY [int] IDENTITY(1,1) NOT NULL,
	LOGDATE Datetime2 NULL,
	PROCEDURENAME [varchar](50) NULL,
	INSERTED INT NULL,
	UPDATED INT NULL,
	ERRORLINE INT NULL,
	ERRORMESSAGE [varchar](200) NULL
) ON [PRIMARY]
GO

PRINT 'TABLE DWH_LOG Created'

GO
/****** View Staging *********************/
/****** CREATE  View [dbo].[VW_LOG]   ******/
CREATE OR ALTER VIEW dbo.VW_LOG
AS
SELECT --TOP (5) 
	  ATT.IPNAME
      ,	ATT.BN_NUMBER
      --,	ATT.SERVICENAME
      --,	ATT.URL_PATH
      ,	ATT.MARKTPARTY
	  , CONCAT(ATT.SERVICENAME, ATT.URL_PATH) AS FKEY
      , L.SOAP
      , L.DATES
FROM FactlessFactDW.dbo.SV_ATTRIBUTES ATT
JOIN FactlessFactDW.dbo.SV_LOG L ON CONCAT(ATT.SERVICENAME, ATT.URL_PATH) = CONCAT(L.SNAME, L.URL_PATH) --(No LEFT) only connections with logs
--AND L.SOAP LIKE 'RECEIVE%'
--AND L.DATES >  CONVERT(datetime, '2022-07-02 10:00:00')
AND L.DATES > (SELECT LAST_LOAD_DATE FROM FactlessFactDW.dbo.LAST_LOAD) --CONVERT(datetime, @lastdate) --Check on last load date (Daily)
GO

PRINT 'VIEW VW_LOG Created'

