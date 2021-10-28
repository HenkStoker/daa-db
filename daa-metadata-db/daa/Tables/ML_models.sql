CREATE TABLE [daa].[ML_models] (
    [SourcePath] NVARCHAR (255) NULL,
    [ModelName]  NVARCHAR (255) NULL,
    [ResultPath] NVARCHAR (255) NULL,
    [enabled]    BIT            NULL,
    [ID]         INT            IDENTITY (1, 1) NOT NULL
);

