



CREATE VIEW [daa].[vw_Active_SourceTables]
AS
SELECT *
FROM daa.BronBestanden bb
WHERE bb.sourceType = 'table'
AND bb.sourceActive = 1
