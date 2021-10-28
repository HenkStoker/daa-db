
Create view [daa].[vw_Enabled_sources] AS
Select * from daa.BronBestanden
Where sourceActive = 1
