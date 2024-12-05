USE [SCOMGER]
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[USP_VentasPorSucursalYAnos_SEL]') AND type in (N'P', N'PC'))
    DROP PROCEDURE [dbo].[USP_VentasPorSucursalYAnos_SEL]
GO

CREATE PROCEDURE USP_VentasPorSucursalYAnos_SEL
    @IdSucursal varchar(3)=NULL,-- Parámetro opcional
    @Anos int  = 10
AS
BEGIN
    SET NOCOUNT ON;
    SET DATEFORMAT DMY;
     
    DECLARE @IdTiempoInicio VARCHAR(10), @IdTiempoFin VARCHAR(10);
    SET @IdTiempoFin = dbo.FnFormatoDimTiempo(GETDATE());
    SET @IdTiempoInicio = dbo.FnFormatoDimTiempo(DATEADD(YEAR,@Anos*(-1),GETDATE()));
    PRINT @IdTiempoFin
    PRINT @IdTiempoInicio
    SELECT DT.Ano AS 'xname',
		   D.IdSucursal AS 'id',
		   DS.Descripcion AS 'name', 
           SUM(D.SubTotal) AS 'yname',
           CAST(DT.Ano AS Varchar(6)) + ': ' + CAST(SUM(D.SubTotal) AS VARCHAR(20)) AS 'Text'
    FROM Datos D
		INNER JOIN DimSucursal DS ON D.IdSucursal = DS.IdSucursal
		INNER JOIN DimTiempo DT ON D.IdTiempo = DT.IdTiempo
    WHERE (D.IdSucursal = @IdSucursal OR @IdSucursal IS NULL) AND 
		  CAST(D.IdTiempo AS INT) BETWEEN CAST(@IdTiempoInicio AS INT) AND CAST(@IdTiempoFin AS INT)
    GROUP BY DT.Ano, D.IdSucursal,DS.Descripcion
    ORDER BY DT.Ano, D.IdSucursal,DS.Descripcion
END

GO


