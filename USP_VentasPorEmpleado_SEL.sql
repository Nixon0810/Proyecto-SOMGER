use SCOMGER
Go
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[USP_VentasPorEmpleado_SEL]') AND type in (N'P', N'PC'))
    DROP PROCEDURE [dbo].[USP_VentasPorEmpleado_SEL]
GO
CREATE PROCEDURE USP_VentasPorEmpleado_SEL
    @MesInicio int,
    @MesFin int,
    @Ano int,
    @IdSucursal varchar(3) = NULL  -- Parámetro opcional
AS
BEGIN
    SET NOCOUNT ON;

    SELECT DE.Descripcion AS 'x', 
           SUM(D.SubTotal) AS 'y',
           DE.Descripcion + ' ' + CAST(SUM(D.SubTotal) AS Varchar(20)) AS 'Text'
    FROM Datos D
    INNER JOIN DimEmpleado DE ON D.IdEmpleado = DE.IdEmpleado
    INNER JOIN DimTiempo DT ON D.IdTiempo = DT.IdTiempo
    /* WHERE (D.IdSucursal = @IdSucursal OR @IdSucursal IS NULL)
       AND DT.Mes BETWEEN @MesInicio AND @MesFin
       AND DT.Ano = @Ano */
    GROUP BY DE.Descripcion;
END
GO
