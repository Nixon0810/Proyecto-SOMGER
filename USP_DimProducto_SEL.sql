USE SCOMGER
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[USP_DimProducto_SEL]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[USP_DimProducto_SEL]
GO
CREATE PROCEDURE USP_DimProducto_SEL
AS
BEGIN
SET NOCOUNT OFF
    SELECT IdProducto, Descripcion
    FROM DimProducto WITH (NOLOCK) ;
END
GO
