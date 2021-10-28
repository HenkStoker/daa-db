CREATE PROCEDURE daa.usp_ReadJsonFile
AS
BEGIN

DECLARE @JSON VARCHAR(MAX)

SELECT @JSON = BulkColumn
FROM OPENROWSET 
(BULK 'C:\Data\VX\FA\Data Analytics and Automation\pl_copy_salesLT.json', SINGLE_CLOB) 
AS j

If (ISJSON(@JSON)=1)
SELECT @JSON AS 'JSON Text'

END