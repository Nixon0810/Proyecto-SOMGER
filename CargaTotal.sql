USE SCOMGER
GO

BEGIN TRANSACTION 
	/*Migra Empleados*/
	MERGE INTO SCOMGER.dbo.DimEmpleado AS tgt
		USING (SELECT CodEmpleado, Descripcion FROM AgroVia.dbo.Empleado) AS src
	ON (tgt.idEmpleado = src.CodEmpleado)
	WHEN NOT MATCHED THEN
		INSERT  (IdEmpleado, Descripcion)
		VALUES  (src.CodEmpleado, src.Descripcion)
	WHEN MATCHED THEN
		UPDATE SET tgt.Descripcion = src.Descripcion;
	
	/*Migra Linea*/   
	MERGE INTO SCOMGER.dbo.DimLinea AS tgt
		USING (SELECT CodLinea, Descripcion FROM AgroVia.dbo.Linea) AS src
	ON (tgt.idLinea = src.CodLinea)
	WHEN NOT MATCHED THEN
		INSERT  (IdLinea, Descripcion)
		VALUES  (src.CodLinea, src.Descripcion)
	WHEN MATCHED THEN
	UPDATE SET tgt.Descripcion = src.Descripcion;
	
	/*Migra Marcas*/
	MERGE INTO SCOMGER.dbo.DimMarca AS tgt
			USING (SELECT CodMarca, Descripcion FROM AgroVia.dbo.Marca) AS src
		ON (tgt.idMarca = src.CodMarca)
		WHEN NOT MATCHED THEN
			INSERT  (IdMarca, Descripcion)
			VALUES  (src.CodMarca, src.Descripcion)
		WHEN MATCHED THEN
		UPDATE SET tgt.Descripcion = src.Descripcion; 
	
	/*Migra Productos*/
	MERGE INTO SCOMGER.dbo.DimProducto AS tgt
		USING (SELECT CodProducto, Descripcion FROM AgroVia.dbo.Producto) AS src
	ON (tgt.idProducto = src.CodProducto)
	WHEN NOT MATCHED THEN
		INSERT  (IdProducto, Descripcion)
		VALUES  (src.CodProducto, src.Descripcion)
	WHEN MATCHED THEN
	UPDATE SET tgt.Descripcion = src.Descripcion; 
	
	/*Migra Sucursal*/
	MERGE INTO SCOMGER.dbo.DimSucursal AS tgt
		USING (SELECT CodAlmacen, Descripcion FROM AgroVia.dbo.Almacen) AS src
	ON (tgt.idSucursal = src.CodAlmacen)
	WHEN NOT MATCHED THEN
		INSERT  (IdSucursal, Descripcion)
		VALUES  (src.CodAlmacen, src.Descripcion)
	WHEN MATCHED THEN
	UPDATE SET tgt.Descripcion = src.Descripcion;

	/*Migra Tiempo*/
	MERGE INTO SCOMGER.dbo.DimTiempo AS tgt
		USING (SELECT CAST(YEAR(FechaVenta) AS Varchar)+
					REPLICATE(0,2-LEN(CAST(MONTH(FechaVenta)AS Varchar)))+CAST(MONTH(FechaVenta)AS Varchar)+
					REPLICATE(0,2-LEN(CAST(DAY(FechaVenta)AS Varchar)))+CAST(DAY(FechaVenta)AS Varchar)+
					REPLICATE(0,2-LEN(CAST(DATEPART(WEEKDAY,FechaVenta)AS Varchar)))+CAST(DATEPART(WEEKDAY,FechaVenta)AS Varchar) AS IdTiempo,
					YEAR(FechaVenta) AS Ano,
					MONTH(FechaVenta)AS Mes,
					DAY(FechaVenta) AS Dia,
					DATEPART(WEEKDAY,FechaVenta) AS DiaSemana
			FROM AgroVia.dbo.Ventas
			GROUP BY YEAR(FechaVenta) ,
					MONTH(FechaVenta),
					DAY(FechaVenta),
					DATEPART(WEEKDAY,FechaVenta)
					) AS src
	ON (tgt.IdTiempo = src.IdTiempo)
	WHEN NOT MATCHED THEN
		INSERT  (IdTiempo, Ano, Mes, Dia, DiaSemana)
		VALUES  (src.IdTiempo,src.Ano, src.Mes, src.Dia, src.DiaSemana)
	WHEN MATCHED THEN
	UPDATE SET tgt.Ano = src.Ano,tgt.Mes = src.Mes,tgt.Dia = src.Dia,tgt.DiaSemana = src.DiaSemana;
	
	/*Migra Datos*/ 
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
		FROM AgroVia.dbo.Ventas AS dv INNER JOIN 
			 AgroVia.dbo.DetalleVentas ddv ON (dv.TransVenta=ddv.Transventa) INNER JOIN
			 AgroVia.dbo.Producto dp ON (ddv.CodProducto=dp.CodProducto)
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