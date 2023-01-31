use [WideWorldImporters]
GO

/* add new column to store encrypted values */
alter table Sales.Customers add
	CustomerNameEncrypted nvarchar(3000) NULL
GO

/* encrypt CustomerName and set its value into CustomerNameEncrypted column */
update Sales.Customers set
	CustomerNameEncrypted = [dbo].[Yl.CryptoApiSqlExtensions.Encrypt](CustomerName, 'ec7b1075-0deb-4c50-81b7-eeb29d60dc49')
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
