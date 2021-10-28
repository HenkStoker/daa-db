CREATE PROCEDURE [dm].[loadDMProduct]( -- daa of nieuw schema dwh?)
	@full_load bit
)
AS
BEGIN
  -- =============================================================================================================
  -- Author		: DAA Project (Mark Mestrum)
  -- Create date	: 16-06-2021
  -- Description	: Procedure voor het laden van de nieuwe/geupdate product data in de Data Mart.
  --
  -- parameters:
  --				01) @full_load,		indien 1, full load van de tabel in de DM
  --									indien 0, incrementeele load van allen de laatst gewijzigde/geupdate data in de DM
  --
  --
  -- Modified By	: Isabell Bones (23-06-2021, comments toegevoegd)
  --
  -- Cave: Wat als Product Tabellen Structuur (Kolommen) in bron veranderen? merged product table structuur in DM wordt niet veranderd tijdens update 
  --
  -- =============================================================================================================
  
  -- maak en SP die óf full load is óf incrementeel. Valideer of deze code gebruikt moet worden door Sinktruncate te checken. code onder @sinktruncate - 1 activeren. 

	DECLARE @SP_IsFullLoad bit = 1
	--@sinkTruncate = 1 --wordt meegegeven bij het aanroepen van de sp
	--declare @IsFullLoad bit
	--select @IsFullLoad = s.sinkTruncate
	--from [daa-metadata-db].[sql_dwh_state] s
	--where s.table_name = @tablename -- kan ook hard coded naar metadata dm.Product

	IF @full_load = @SP_IsFullLoad --1=@IsFullLoad
	BEGIN
    --Full load, [stg_adv_works].[Product] data in [dm].[Product]
		TRUNCATE TABLE dm.Product
		INSERT INTO dm.Product([ProductID]
      ,[Name]
      ,[ProductNumber]
      ,[Color]
      ,[StandardCost]
      ,[ListPrice]
      ,[ProductCategoryID]
      ,[ProductModelID]
      ,[SellStartDate]
      ,[SellEndDate]
      ,[DiscontinuedDate]
      ,[rowguid]
      ,[Bron]
	  ,[InsertedInDM] -- TO DO data type aanpassen naar datetime2
      	  )
		SELECT 
		  productID
		, name
		, productNumber
		, color
		, StandardCost
		, listprice
		, productcategoryID
		, ProductModelID
		, [SellStartDate]
		, [SellEndDate]
		, [DiscontinuedDate]
		, [rowguid]
		, [Bron]
		, SYSDATETIME() -- welke data type
		FROM  [stg_adv_works].[Product]
	END
	ELSE -- @Full_load <> @SP_IsFullLoad
--	
--	-- TO DO error melding, later op focusen
--	SELECT ERROR_MESSAGE() AS ErrorMessage
--	--BEGIN
--	--	DELETE A
--	--	FROM dm.Product a
--	--		INNER JOIN  daa.productb ON a.ProductID = b.ProductID
--
-- --    ;WITH LatestModifiedOn AS
--	--(
--	--	SELECT ProductID
--	--		 , MAX(ModifiedDate) modifiedDate
--	--	FROM daa.Product
--	--	GROUP BY ProductID
--	--)
--	--INSERT INTO dm.Product ([ProductID],[Name],[ProductNumber],[Color],[StandardCost],[ListPrice],[ProductCategoryID],[ProductModelID],[SellStartDate],[SellEndDate],[DiscontinuedDate],[rowguid],[Bron], InsertedInDM)
--	--	SELECT a.ProductID, a.name, a.ProductNumber, a. standardcost, a.listprice, a.productcategoryID, a.productmodelID, a.Sellstartdate, a.sellenddate, a.discontinueddate, a.rowguid, a.bron, a.modifedDate
--	--	FROM daa.Product a
--	--	JOIN LatestModifiedOn b ON a.productID = b.ProductID AND a.ModifiedDate = b.ModifiedDate
--	--	--De laatste wijziging in de staging. Alleen als je de historie NIET in de datamart wil. Voor nu is dat prima.
--	--	--update bestaande records/inserten nieuwe records
--
--	--END
      BEGIN
        --
        -- Merge Products
        --
        MERGE [dm].[Product] AS dst
        USING ( SELECT stg_p.[ProductID]
                ,      stg_p.[Name]
                ,      stg_p.[ProductNumber]
                ,      stg_p.[Color]
                ,      stg_p.[StandardCost]
                ,      stg_p.[ListPrice]
--                ,      stg_p.[Size]
--                ,      stg_p.[p.Weight]
                ,      stg_p.[ProductCategoryID]
                ,      stg_p.[ProductModelID]
                ,      stg_p.[SellStartDate]
                ,      stg_p.[SellEndDate]
                ,      stg_p.[DiscontinuedDate]
                ,      stg_p.[rowguid]
                ,      stg_p.[Bron]
                ,      stg_p.[LoadDate]
--                ,      stg_p.[InsertedInDWH]
                FROM   [stg_adv_works].[Product] AS stg_p
          ) AS src ON dst.[ProductID] = src.[ProductID]
                  AND dst.[ValidTo] IS NULL
        --
        WHEN NOT MATCHED BY TARGET
        THEN
        INSERT
          ( [ProductID]
          , [Name]
          , [ProductNumber]
          , [Color]
          , [StandardCost]
          , [ListPrice]
          , [ProductCategoryID]
          , [ProductModelID]
          , [SellStartDate]
          , [SellEndDate]
          , [DiscontinuedDate]
          , [rowguid]
          , [Bron]
    	  , [InsertedInDM]
          , [ValidFrom]
          , [ValidTo]
          )
        VALUES 
          ( src.[ProductID]
          , src.[Name]
          , src.[ProductNumber]
          , src.[Color]
          , src.[StandardCost]
          , src.[ListPrice]
          , src.[ProductCategoryID]
          , src.[ProductModelID]
          , src.[SellStartDate]
          , src.[SellEndDate]
          , src.[DiscontinuedDate]
          , src.[rowguid]
          , src.[Bron]
          , SYSDATETIME() -- CURRENT_TIMESTAMP
          , src.[LoadDate]
          , NULL		  
    	  )
        --
        WHEN MATCHED AND
          ( ISNULL(dst.[Name], '')  <> ISNULL(src.[Name], '')
            OR dst.[ProductNumber]  <> src.[ProductNumber]
            OR ISNULL(dst.[Color], '')  <> ISNULL(src.[Color], '')
            OR dst.[StandardCost]  <> src.[StandardCost]
            OR dst.[ListPrice]  <> src.[ListPrice]
            OR ISNULL(CAST(dst.[ProductCategoryID] as nvarchar(255)), '')  <> ISNULL(CAST(src.[ProductCategoryID] as nvarchar(255)), '')
            OR ISNULL(CAST(dst.[ProductModelID] as nvarchar(255)), '')  <> ISNULL(CAST(src.[ProductModelID] as nvarchar(255)), '')
            OR dst.[SellStartDate]  <> src.[SellStartDate]
            OR ISNULL(CAST(dst.[SellEndDate] as nvarchar(255)), '')  <> ISNULL(CAST(src.[SellEndDate] as nvarchar(255)), '')
            OR ISNULL(CAST(dst.[DiscontinuedDate] as nvarchar(255)), '')  <> ISNULL(CAST(src.[DiscontinuedDate] as nvarchar(255)), '')
            OR dst.[rowguid]  <> src.[rowguid]
            OR ISNULL(dst.[Bron], '')  <> ISNULL(src.[Bron], '')
          )
        THEN
        UPDATE
          SET [ValidTo] = src.[LoadDate]
		;
		--
        INSERT INTO [dm].[Product]
          ( [ProductID]
          , [Name]
          , [ProductNumber]
          , [Color]
          , [StandardCost]
          , [ListPrice]
          , [ProductCategoryID]
          , [ProductModelID]
          , [SellStartDate]
          , [SellEndDate]
          , [DiscontinuedDate]
          , [rowguid]
          , [Bron]
    	  , [InsertedInDM]
          , [ValidFrom]
          , [ValidTo]
          )
        SELECT stg_p.[ProductID]
        ,      stg_p.[Name]
        ,      stg_p.[ProductNumber]
        ,      stg_p.[Color]
        ,      stg_p.[StandardCost]
        ,      stg_p.[ListPrice]
        ,      stg_p.[ProductCategoryID]
        ,      stg_p.[ProductModelID]
        ,      stg_p.[SellStartDate]
        ,      stg_p.[SellEndDate]
        ,      stg_p.[DiscontinuedDate]
        ,      stg_p.[rowguid]
        ,      stg_p.[Bron]
        ,      SYSDATETIME()
        ,      stg_p.[LoadDate]
        ,      NULL
        FROM   [stg_adv_works].[Product] AS stg_p
        WHERE  EXISTS
                 ( SELECT '1'
                   FROM   [dm].[Product] AS dst
                   WHERE  stg_p.[ProductID] = dst.[ProductID]
                   AND    dst.[ValidTo]     = stg_p.[LoadDate]
                 )
        AND    NOT EXISTS
                 ( SELECT '1'
                   FROM   [dm].[Product] AS dst
                   WHERE  stg_p.[ProductID] = dst.[ProductID]
                   AND    dst.[ValidTo] IS NULL				   
                 )
        ;
        --
	  END;
END;
