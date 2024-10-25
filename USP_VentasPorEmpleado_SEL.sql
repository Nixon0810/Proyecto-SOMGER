USE SCOMGER
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[USP_VentasPorEmpleado_SEL]') AND type in (N'P', N'PC'))
    DROP PROCEDURE [dbo].[USP_VentasPorEmpleado_SEL]
GO

CREATE PROCEDURE USP_VentasPorEmpleado_SEL
    @FechaInicio DATE,
    @FechaFin DATE,
    @IdSucursal VARCHAR(3) = NULL  -- Parámetro opcional
AS
BEGIN
    SET NOCOUNT ON;
    SET DATEFORMAT DMY;

    DECLARE @IdTiempoInicio VARCHAR(10), @IdTiempoFin VARCHAR(10);
    SET @IdTiempoInicio = dbo.FnFormatoDimTiempo(@FechaInicio);
    SET @IdTiempoFin = dbo.FnFormatoDimTiempo(@FechaFin);

    SELECT DE.Descripcion AS 'x', 
           SUM(D.SubTotal) AS 'y',
           DE.Descripcion + ' ' + CAST(SUM(D.SubTotal) AS VARCHAR(20)) AS 'Text'
    FROM Datos D
    INNER JOIN DimEmpleado DE ON D.IdEmpleado = DE.IdEmpleado
    INNER JOIN DimTiempo DT ON D.IdTiempo = DT.IdTiempo
    WHERE (D.IdSucursal = @IdSucursal OR @IdSucursal IS NULL)
      AND (CAST(D.IdTiempo AS INT) BETWEEN CAST(@IdTiempoInicio AS INT) AND CAST(@IdTiempoFin AS INT))
    GROUP BY DE.Descripcion;
END
GO
