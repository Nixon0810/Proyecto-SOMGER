Use SCOMGER
Go
CREATE PROCEDURE USP_VentasPorProducto_SEL
    @MesInicio int,
    @MesFin int,
    @Ano int,
    @IdSucursal varchar(3) = NULL,  
    @IdEmpleado varchar(3) = NULL,  
    @IdLinea varchar(5) = NULL  
AS
BEGIN
    SET NOCOUNT ON;

    SELECT D.IdProducto, DP.Descripcion, SUM(D.CantidadVendida) AS TotalCantidadVendida, SUM(D.SubTotal) AS TotalSubTotal
    FROM Datos D
    INNER JOIN DimProducto DP ON D.IdProducto = DP.IdProducto
    INNER JOIN DimTiempo DT ON D.IdTiempo = DT.IdTiempo
    WHERE (D.IdSucursal = @IdSucursal OR @IdSucursal IS NULL)
      AND (D.IdEmpleado = @IdEmpleado OR @IdEmpleado IS NULL)
      AND (D.IdLinea = @IdLinea OR @IdLinea IS NULL)
      AND DT.Mes BETWEEN @MesInicio AND @MesFin
      AND DT.Ano = @Ano
    GROUP BY D.IdProducto, DP.Descripcion;
END
GO

