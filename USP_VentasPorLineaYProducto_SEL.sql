USE [SCOMGER]
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[USP_VentasPorLineaYProducto_SEL]') AND type in (N'P', N'PC'))
    DROP PROCEDURE [dbo].[USP_VentasPorLineaYProducto_SEL]
GO

CREATE PROCEDURE USP_VentasPorLineaYProducto_SEL
    @FechaInicio DATE,
    @FechaFin DATE,
    @IdSucursal VARCHAR(3) = NULL, -- Parámetro opcional para sucursal
    @IdLinea VARCHAR(5) = NULL     -- Parámetro opcional para línea
AS
BEGIN
    SET NOCOUNT ON;
    SET DATEFORMAT DMY;

    DECLARE @IdTiempoInicio VARCHAR(10), @IdTiempoFin VARCHAR(10);
    SET @IdTiempoInicio = dbo.FnFormatoDimTiempo(@FechaInicio);
    SET @IdTiempoFin = dbo.FnFormatoDimTiempo(@FechaFin);

    SELECT 
        DP.IdProducto,
        DP.Descripcion AS Producto,
        SUM(D.CantidadVendida) AS Cantidad,
        CASE 
            WHEN SUM(D.CantidadVendida) > 0 THEN ROUND(SUM(D.SubTotal) / SUM(D.CantidadVendida), 4)
            ELSE 0
        END AS PrecioPromedio,
        SUM(D.SubTotal) AS SubTotal
    FROM Datos D
    INNER JOIN DimProducto DP ON D.IdProducto = DP.IdProducto
    INNER JOIN DimTiempo DT ON D.IdTiempo = DT.IdTiempo
    WHERE (D.IdSucursal = @IdSucursal OR @IdSucursal IS NULL)  -- Filtra por sucursal, si se proporciona
      AND (D.IdLinea = @IdLinea OR @IdLinea IS NULL)           -- Filtra por línea, si se proporciona
      AND (CAST(D.IdTiempo AS INT) BETWEEN CAST(@IdTiempoInicio AS INT) AND CAST(@IdTiempoFin AS INT))  -- Filtra por fechas
    GROUP BY DP.IdProducto,DP.Descripcion  
    ORDER BY DP.Descripcion; 
END

GO


