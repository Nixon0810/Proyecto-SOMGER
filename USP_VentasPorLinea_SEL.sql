USe SCOMGER
Go
CREATE PROCEDURE USP_VentasPorLinea_SEL
    @MesInicio int,
    @MesFin int,
    @Ano int,
    @IdSucursal varchar(3) = NULL,  
    @IdEmpleado varchar(3) = NULL  
AS
BEGIN
    SET NOCOUNT ON;

    SELECT D.IdLinea, DL.Descripcion, SUM(D.CantidadVendida) AS TotalCantidadVendida, SUM(D.SubTotal) AS TotalSubTotal
    FROM Datos D
    INNER JOIN DimLinea DL ON D.IdLinea = DL.IdLinea
    INNER JOIN DimTiempo DT ON D.IdTiempo = DT.IdTiempo
    WHERE (D.IdSucursal = @IdSucursal OR @IdSucursal IS NULL)
      AND (D.IdEmpleado = @IdEmpleado OR @IdEmpleado IS NULL)
      AND DT.Mes BETWEEN @MesInicio AND @MesFin
      AND DT.Ano = @Ano
    GROUP BY D.IdLinea, DL.Descripcion;
END
GO

