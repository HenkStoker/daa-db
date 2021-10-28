
-- =============================================================================================================
-- Author		: DAA Project (Mark Mestrum)
-- Create date	: 16-06-2021
-- Description	: Procedure voor het laden van de nieuwe/geupdate sales data in de Data Mart.
--
-- parameters:
--				01) @full_load,		indien 1, full load van de tabel in de DM
--									indien 0, incrementeele load van allen de laatst gewijzigde/geupdate data in de DM
--
--
-- Modified By	: Isabell Bones (22-06-2021, comments toegevoegd)
--
-- Cave: Wat als Sales Tabellen Structuur (Kolommen) in bron veranderen? merged sales table structuur in DM wordt niet veranderd tijdens update 
--
-- =============================================================================================================

CREATE PROCEDURE [dm].[loadDMSales](
@full_load bit
)
	
AS
BEGIN
-- @SP_isFullLoad: ter controlle dat full of incremental load correct worden doorgegeven 
	Declare @SP_IsFullLoad bit = 0

	IF @full_load = @SP_IsFullLoad
	Begin

-- merge de twee tabellen 'SalesOrderDetail' en 'SalesOrderHeader' in #salestablesjoin	
	SELECT
	   A.[SalesOrderID]
	  ,[SalesOrderDetailID]
	  ,[SalesOrderNumber]
	  ,[PurchaseOrderNumber]
      ,[ProductID]
	  ,[OrderQty]
      ,[UnitPrice]
      ,[UnitPriceDiscount]
      ,[LineTotal]
	  ,[AccountNumber]
      ,[CustomerID]
      ,[ShipToAddressID]
      ,[BillToAddressID]
      ,[OrderDate]
      ,[DueDate]
      ,[ShipDate]
	  ,A.InsertedInDWH
	INTO #salestablesjoin FROM [stg_adv_works].[SalesOrderDetail] A
	LEFT JOIN [stg_adv_works].[SalesOrderHeader] B 
		ON A.salesorderid = B.salesorderid

--  'oude' data van tabel stg_adv_works.SalesInfo verwijderen
	DELETE A
	FROM dm.salesOrderinfo a
		INNER JOIN  #salestablesjoin b ON a.SalesOrderID = b.SalesOrderID

-- selecteer recentelijk gewijzigde data in CTE LatestModifiedOn via Date'insertedinDWH' 	
   ;WITH LatestModifiedOn AS
	(
		SELECT SalesOrderID
			 , MAX(insertedinDWH) AS InsertedinDWH
		FROM #salestablesjoin
		GROUP BY SalesOrderID
	)

-- #salestablesjoin platsen in data mart tabel dm.SalesOrderInfo	
	INSERT INTO dm.SalesOrderInfo (
	   SalesOrderID 
	  ,[SalesOrderDetailID]
      ,[SalesOrderNumber]
      ,[PurchaseOrderNumber]
      ,[ProductID]
      ,[OrderQty]
      ,[UnitPrice]
      ,[UnitPriceDiscount]
      ,[LineTotal]
      ,[AccountNumber]
      ,[CustomerID]
      ,[ShipToAddressID]
      ,[BillToAddressID]
      ,[OrderDate]
      ,[DueDate]
      ,[ShipDate]
      ,[InsertedInDM])
-- selecteer alleen de recentelijk gewijzigde rows van #salestablesjoin via LatestModifiedOn
	SELECT 
	    a.SalesOrderID 
	  ,[SalesOrderDetailID]
	  ,[SalesOrderNumber]
      ,[PurchaseOrderNumber]
      ,[ProductID]
      ,[OrderQty]
      ,[UnitPrice]
      ,[UnitPriceDiscount]
      ,[LineTotal]
      ,[AccountNumber]
      ,[CustomerID]
      ,[ShipToAddressID]
      ,[BillToAddressID]
      ,[OrderDate]
      ,[DueDate]
      ,[ShipDate]
      ,GETDATE()
		FROM #salestablesjoin a
		JOIN LatestModifiedOn b ON a.SalesOrderID = b.SalesOrderID AND a.InsertedinDWH = b.InsertedinDWH

END
ELSE
-- TO DO: error melding, later op focusen
	SELECT ERROR_MESSAGE() AS ErrorMessage

end
