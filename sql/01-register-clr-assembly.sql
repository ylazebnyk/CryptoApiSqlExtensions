/*
* Script require following changes before it could be run:
* Replace <<LoginName>> with db login name
* Verify .net 4 path: C:\Windows\Microsoft.NET\Framework64\v4.0.30319
* Set path to the assembly being registered: D:\github\_yl\Yl.CryptoApiSqlExtensions\bin\Debug\Yl.CryptoApiSqlExtensions.dll
* SqlServer 2012+
*/


sp_configure 'show advanced options', 1;
GO
RECONFIGURE;
GO

sp_configure 'clr enabled', 1;
GO
RECONFIGURE;
GO

USE [WideWorldImporters]
GO
ALTER DATABASE [WideWorldImporters] SET TRUSTWORTHY ON;
EXEC sp_changedbowner 'sa'

/*sync SID records for DB owner between current and master DB*/
/*http://stackoverflow.com/questions/12389656/the-database-owner-sid-recorded-in-the-master-database-differs-from-the-database*/
DECLARE @Command VARCHAR(MAX) = 'ALTER AUTHORIZATION ON DATABASE::WideWorldImporters TO 
[<<LoginName>>]' 

SELECT @Command = REPLACE(REPLACE(@Command 
            , 'WideWorldImporters', SD.Name)
            , '<<LoginName>>', SL.Name)
FROM master..sysdatabases SD 
JOIN master..syslogins SL ON  SD.SID = SL.SID
WHERE  SD.Name = DB_NAME()

PRINT @Command
EXEC(@Command)


/*register  assembly*/
create assembly [System.Net.Http] from 'C:\Windows\Microsoft.NET\Framework64\v4.0.30319\System.Net.Http.dll' WITH PERMISSION_SET = UNSAFE;
GO
create assembly [Yl.CryptoApiSqlExtensions] from 'D:\github\_yl\Yl.CryptoApiSqlExtensions\bin\Debug\Yl.CryptoApiSqlExtensions.dll' WITH PERMISSION_SET = UNSAFE;
GO
