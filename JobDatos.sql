USE SCOMGER
GO

CREATE PROCEDURE PaSCOMGER_JobDato AS
BEGIN
BEGIN TRANSACTION 
	MERGE INTO SCOMGER.dbo.Datos AS tgt
	USING (
		SELECT 
			dv.CodAlmacen AS IdSucursal, 
			CAST(YEAR(FechaVenta) AS Varchar)+
			REPLICATE(0,2-LEN(CAST(MONTH(FechaVenta)AS Varchar)))+CAST(MONTH(FechaVenta)AS Varchar)+
			REPLICATE(0,2-LEN(CAST(DAY(FechaVenta)AS Varchar)))+CAST(DAY(FechaVenta)AS Varchar)+
			REPLICATE(0,2-LEN(CAST(DATEPART(WEEKDAY,FechaVenta)AS Varchar)))+CAST(DATEPART(WEEKDAY,FechaVenta)AS Varchar) AS IdTiempo,
			dv.CodEmpleado AS IdEmpleado, 
			ddv.CodProducto AS IdProducto, 
			dp.CodMarca AS IdMarca, 
			dp.CodLinea As IdLinea, 
			SUM(ddv.CantidadAfectaStock) AS CantidadVendida,  
			SUM(ddv.SubTotal) AS SubTotal  
		FROM BDComercial.dbo.Ventas AS dv INNER JOIN 
			 BDComercial.dbo.DetalleVentas ddv ON (dv.TransVenta=ddv.Transventa) INNER JOIN
			 BDComercial.dbo.Producto dp ON (ddv.CodProducto=dp.CodProducto)
		GROUP BY 
			dv.CodAlmacen, 
			CAST(YEAR(FechaVenta) AS Varchar)+
			REPLICATE(0,2-LEN(CAST(MONTH(FechaVenta)AS Varchar)))+CAST(MONTH(FechaVenta)AS Varchar)+
			REPLICATE(0,2-LEN(CAST(DAY(FechaVenta)AS Varchar)))+CAST(DAY(FechaVenta)AS Varchar)+
			REPLICATE(0,2-LEN(CAST(DATEPART(WEEKDAY,FechaVenta)AS Varchar)))+CAST(DATEPART(WEEKDAY,FechaVenta)AS Varchar),
			dv.CodEmpleado, 
			ddv.CodProducto, 
			dp.CodMarca, 
			dp.CodLinea
	) AS src
	ON (
		tgt.IdSucursal = src.IdSucursal AND
		tgt.IdTiempo = src.IdTiempo AND
		tgt.IdEmpleado = src.IdEmpleado AND
		tgt.IdProducto = src.IdProducto AND
		tgt.IdMarca = src.IdMarca AND
		tgt.IdLinea = src.IdLinea
	)
	WHEN NOT MATCHED THEN
		INSERT (IdSucursal, IdTiempo, IdEmpleado, IdProducto, IdMarca, IdLinea, CantidadVendida, SubTotal)
		VALUES (src.IdSucursal, src.IdTiempo, src.IdEmpleado, src.IdProducto, src.IdMarca, src.IdLinea, src.CantidadVendida, src.SubTotal)
	WHEN MATCHED THEN
		UPDATE SET 
			tgt.CantidadVendida = tgt.CantidadVendida,  
			tgt.SubTotal = tgt.SubTotal;  
COMMIT TRANSACTION
END
GO