use SCOMGER
Go
CREATE PROCEDURE USP_VentasPorAnoYSucursal_SEL
    @MesInicio int,
    @MesFin int,
    @Ano int,
    @IdSucursal varchar(3) = NULL 
AS
BEGIN
    SET NOCOUNT ON;

    SELECT D.IdSucursal, DS.Descripcion, SUM(D.CantidadVendida) AS TotalCantidadVendida, SUM(D.SubTotal) AS TotalSubTotal
    FROM Datos D
    INNER JOIN DimSucursal DS ON D.IdSucursal = DS.IdSucursal
    INNER JOIN DimTiempo DT ON D.IdTiempo = DT.IdTiempo
    WHERE (D.IdSucursal = @IdSucursal OR @IdSucursal IS NULL)
      AND DT.Mes BETWEEN @MesInicio AND @MesFin
      AND DT.Ano = @Ano
    GROUP BY D.IdSucursal, DS.Descripcion;
END
GO
