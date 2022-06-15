/****** Load DWH   ******/

USE [FactlessFactDW]
GO

--truncate table dbo.Fact_Log

exec [FactlessFactDW].dbo.Load_Dim_IP;

exec [FactlessFactDW].dbo.Load_Dim_SOAP;

exec [FactlessFactDW].dbo.Load_Dim_BN;

exec [FactlessFactDW].dbo.Load_Fact