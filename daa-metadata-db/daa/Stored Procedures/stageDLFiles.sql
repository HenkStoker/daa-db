
-- =============================================
-- Author:      DAA Project, Leon Berlang
-- Create Date: 27-10-2021
-- Description: Procedure om data lake files te stagen zodat deze geordend kunnen worden.
--				Indien tabel niet beschikbaar wordt deze aangemaakt.
-- Input:		dl_files_string (json) met files om te kunnen parsen. 
-- =============================================
CREATE PROCEDURE [daa].[stageDLFiles]
(
    @json_string varchar(1000)	
)
AS
BEGIN
    -- SET NOCOUNT ON added to prevent extra result sets from
    -- interfering with SELECT statements.
    SET NOCOUNT ON

    -- Insert statements for procedure here
    IF NOT EXISTS (
	SELECT * FROM sysobjects WHERE name='DLMetaFiles' and xtype='U')
    CREATE TABLE [daa-metadata-db].[daa].[DLMetaFiles] (
        [FileName] varchar(8) NOT NULL
		, [FileType] varchar(50)
		, [LastModifiedDateTime] datetime2
    )
END
