USE SCOMGER
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[USP_VentasPorProducto_SEL]') AND type in (N'P', N'PC'))
    DROP PROCEDURE [dbo].[USP_VentasPorProducto_SEL]
GO

CREATE PROCEDURE USP_VentasPorProducto_SEL
    @FechaInicio DATE,
    @FechaFin DATE,
    @IdSucursal VARCHAR(3) = NULL,  
    @IdEmpleado VARCHAR(3) = NULL,  
    @IdLinea VARCHAR(5) = NULL  
AS
BEGIN
    SET NOCOUNT ON;
    SET DATEFORMAT DMY;
    
    DECLARE @IdTiempoInicio VARCHAR(10), @IdTiempoFin VARCHAR(10);
    SET @IdTiempoInicio = dbo.FnFormatoDimTiempo(@FechaInicio);
    SET @IdTiempoFin = dbo.FnFormatoDimTiempo(@FechaFin);

    SELECT DP.Descripcion AS 'x', 
           SUM(D.SubTotal) AS 'y',
           DP.Descripcion + ' ' + CAST(SUM(D.SubTotal) AS VARCHAR(20)) AS 'Text'
    FROM Datos D
    INNER JOIN DimProducto DP ON D.IdProducto = DP.IdProducto
    INNER JOIN DimTiempo DT ON D.IdTiempo = DT.IdTiempo
    WHERE (D.IdSucursal = @IdSucursal OR @IdSucursal IS NULL)
      AND (D.IdEmpleado = @IdEmpleado OR @IdEmpleado IS NULL)
      AND (D.IdLinea = @IdLinea OR @IdLinea IS NULL)
      AND (CAST(D.IdTiempo AS INT) BETWEEN CAST(@IdTiempoInicio AS INT) AND CAST(@IdTiempoFin AS INT))
    GROUP BY DP.IdProducto,DP.Descripcion;
END
GO
