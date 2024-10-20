USE SCOMGER
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[USP_DimMarca_SEL]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[USP_DimMarca_SEL]
GO
CREATE PROCEDURE USP_DimMarca_SEL
AS
BEGIN
SET NOCOUNT OFF
    SELECT IdMarca, Descripcion
    FROM DimMarca WITH (NOLOCK) ;
END
GO
