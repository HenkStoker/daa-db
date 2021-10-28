CREATE PROC [daa].[UpdateLastLoadDate](
@SPname varchar(112)
)
AS 


UPDATE daa.stored_procedures
SET last_load_date = CAST(SYSDATETIMEOFFSET() AT TIME ZONE 'W. Europe Standard Time' as nvarchar)
WHERE stored_procedure_name = @SPname
