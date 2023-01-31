USE [WideWorldImporters]
GO

/*create proxy function to access assembly from sql*/
create function [dbo].[Yl.CryptoApiSqlExtensions.Encrypt](@value As nvarchar(245), @token As nvarchar(40))
	returns nvarchar(2000)
	as external name [Yl.CryptoApiSqlExtensions].[Yl.CryptoApiSqlExtensions.SqlApi].[Encrypt]
GO

create function [dbo].[Yl.CryptoApiSqlExtensions.Decrypt](@value As nvarchar(2000), @token As nvarchar(40))
	returns nvarchar(245)
	as external name [Yl.CryptoApiSqlExtensions].[Yl.CryptoApiSqlExtensions.SqlApi].[Decrypt]
GO
