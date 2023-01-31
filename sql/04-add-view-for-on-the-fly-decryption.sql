use [WideWorldImporters]
GO
/*
* create a view that is decrypting values on the fly.
* .net clr function is used that is called sequentially for each value.
* clr function is calling http web service for decryption.
* current sample is decrypting ~10 lines per second. could take a while to process big dataset
*/
ALTER VIEW [dbo].[SalesCustomersDecrypted]
AS
SELECT CustomerID, CreditLimit, AccountOpenedDate, StandardDiscountPercentage, PhoneNumber, WebsiteURL, dbo.[Yl.CryptoApiSqlExtensions.Decrypt](CustomerNameEncrypted, N'ec7b1075-0deb-4c50-81b7-eeb29d60dc49') AS CustomerNameDecrypted
FROM Sales.Customers
GO

/* sample run with decryption */
SELECT TOP (10) * FROM [WideWorldImporters].[dbo].[SalesCustomersDecrypted]
