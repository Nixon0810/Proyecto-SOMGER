use SCOMGER
Go
CREATE PROCEDURE USP_VentasPorEmpleado_SEL
    @MesInicio int,
    @MesFin int,
    @Ano int,
    @IdSucursal varchar(3) = NULL  -- Parámetro opcional
AS
BEGIN
    SET NOCOUNT ON;

    SELECT D.IdEmpleado, DE.Descripcion, SUM(D.CantidadVendida) AS TotalCantidadVendida, SUM(D.SubTotal) AS TotalSubTotal
    FROM Datos D
    INNER JOIN DimEmpleado DE ON D.IdEmpleado = DE.IdEmpleado
    INNER JOIN DimTiempo DT ON D.IdTiempo = DT.IdTiempo
    WHERE (D.IdSucursal = @IdSucursal OR @IdSucursal IS NULL)
      AND DT.Mes BETWEEN @MesInicio AND @MesFin
      AND DT.Ano = @Ano
    GROUP BY D.IdEmpleado, DE.Descripcion;
END
GO

