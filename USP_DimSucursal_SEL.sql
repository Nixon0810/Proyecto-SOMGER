USE SCOMGER
GO
CREATE PROCEDURE USP_DimSucursal_SEL AS
BEGIN

  SET NOCOUNT OFF

	SELECT [IdSucursal]
		  ,[Descripcion]
	  FROM [SCOMGER].[dbo].[DimSucursal] WITH (NOLOCK) ;
  
END
GO