CREATE PROC [daa].[UpdateLastLoadDate_Source](
@objectName nvarchar(200),
@loadDate nvarchar(50)
)
AS 


UPDATE daa.BronBestanden
SET lastLoadDate = @loadDate
WHERE objectName = @objectName
