USE SCOMGER
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[USP_DimEmpleado_SEL]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[USP_DimEmpleado_SEL]
GO
CREATE PROCEDURE USP_DimEmpleado_SEL
AS
BEGIN
SET NOCOUNT OFF
    SELECT IdEmpleado, Descripcion
    FROM DimEmpleado WITH (NOLOCK) ;
END
GO