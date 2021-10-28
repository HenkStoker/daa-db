
CREATE VIEW [daa].[vw_Enabled_SP] AS
SELECT * FROM daa.stored_procedures
WHERE enabled = 1
