USE SCOMGER
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[USP_DimLinea_SEL]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[USP_DimLinea_SEL]
GO
CREATE PROCEDURE USP_DimLinea_SEL
AS
BEGIN
SET NOCOUNT OFF
    SELECT IdLinea, Descripcion
    FROM DimLinea WITH (NOLOCK) ;
END
GO
