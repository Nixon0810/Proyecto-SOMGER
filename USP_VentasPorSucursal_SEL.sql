USE SCOMGER
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[USP_VentasPorSucursal_SEL]') AND type in (N'P', N'PC'))
    DROP PROCEDURE [dbo].[USP_VentasPorSucursal_SEL]
GO

CREATE PROCEDURE USP_VentasPorSucursal_SEL
    @FechaInicio DATE,
    @FechaFin DATE,
    @IdSucursal INT = NULL  
AS
BEGIN
    SET NOCOUNT ON;
    SET DATEFORMAT DMY;
    
    DECLARE @IdTiempoInicio VARCHAR(10), @IdTiempoFin VARCHAR(10);
    SET @IdTiempoInicio = dbo.FnFormatoDimTiempo(@FechaInicio);
    SET @IdTiempoFin = dbo.FnFormatoDimTiempo(@FechaFin);

    
    SELECT DS.Descripcion AS 'x', 
           SUM(D.SubTotal) AS 'y',
           DS.Descripcion + ' ' + CAST(SUM(D.SubTotal) AS VARCHAR(20)) AS 'Text'
    FROM Datos D
         INNER JOIN DimSucursal DS ON D.IdSucursal = DS.IdSucursal
         INNER JOIN DimTiempo DT ON D.IdTiempo = DT.IdTiempo
    WHERE (CAST(D.IdTiempo AS INT) BETWEEN CAST(@IdTiempoInicio AS INT) AND CAST(@IdTiempoFin AS INT))
      AND (@IdSucursal IS NULL OR D.IdSucursal = @IdSucursal)  
    GROUP BY DS.Descripcion;
END
GO
