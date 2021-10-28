CREATE TABLE [daa].[stored_procedures] (
    [id]                      INT            IDENTITY (1, 1) NOT NULL,
    [stored_procedure_schema] NVARCHAR (50)  NOT NULL,
    [stored_procedure_name]   NVARCHAR (112) NOT NULL,
    [full_load]               BIT            NOT NULL,
    [enabled]                 BIT            NOT NULL,
    [last_load_date]          DATE           NULL,
    [priority]                INT            NOT NULL,
    [source]                  NVARCHAR (100) NULL,
    CONSTRAINT [PK_sql_dwh_state] PRIMARY KEY CLUSTERED ([id] ASC)
);

