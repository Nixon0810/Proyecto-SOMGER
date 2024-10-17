use SCOMGER
Go

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[USP_VentasPorAnoYSucursal_SEL]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[USP_VentasPorAnoYSucursal_SEL]
GO

CREATE PROCEDURE USP_VentasPorAnoYSucursal_SEL
    @MesInicio int,
    @MesFin int,
    @Ano int,
    @IdSucursal varchar(3) = NULL 
AS
BEGIN
    SET NOCOUNT ON;

    SELECT	DS.Descripcion AS 'x', 
			SUM(D.SubTotal) AS 'y',
			DS.Descripcion+' '+CAST(SUM(D.SubTotal) AS Varchar(20)) AS 'Text'
    FROM Datos D
		INNER JOIN DimSucursal DS ON D.IdSucursal = DS.IdSucursal
		INNER JOIN DimTiempo DT ON D.IdTiempo = DT.IdTiempo
   /* WHERE (D.IdSucursal = @IdSucursal OR @IdSucursal IS NULL)
		AND DT.Mes BETWEEN @MesInicio AND @MesFin
		AND DT.Ano = @Ano*/
    GROUP BY DS.Descripcion;
END
GO
