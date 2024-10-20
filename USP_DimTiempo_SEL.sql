USE SCOMGER
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[USP_DimTiempo_SEL]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[USP_DimTiempo_SEL]
GO
CREATE PROCEDURE USP_DimTiempo_SEL
AS
BEGIN
SET NOCOUNT OFF
    SELECT IdTiempo, Ano,Mes,Dia,DiaSemana
    FROM DimTiempo WITH (NOLOCK) ;
END
GO
