

CREATE VIEW [daa].[vw_Active_SourceFiles]
AS
SELECT *
FROM daa.BronBestanden bb
WHERE bb.sourceType = 'file'
AND bb.sourceActive = 1
