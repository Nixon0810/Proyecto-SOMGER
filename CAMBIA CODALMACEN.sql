DECLARE @CodAlmacenAnterior Varchar(3)
DECLARE @CodAlmacenNuevo Varchar(3)
SET @CodAlmacenAnterior='002' 
SET @CodAlmacenNuevo='001' 

--INSERTA EL MISMO ALMACEN CON CODIGO DIFERENTE
INSERT INTO Almacen([CodAlmacen]
	  ,[Descripcion]
      ,[CodEmpresa]
      ,[Direccion]
      ,[CodigoSUNAT]
	  ,[Estado])
SELECT @CodAlmacenNuevo
      ,[Descripcion]
      ,[CodEmpresa]
      ,[Direccion]
      ,[CodigoSUNAT]
	  ,0
FROM [dbo].[Almacen]
WHERE CodAlmacen = @CodAlmacenAnterior

--CAMBIA TABLA DE SERIES
UPDATE SeriesDocumento 
SET [CodAlmacen] = @CodAlmacenNuevo
WHERE CodAlmacen = @CodAlmacenAnterior

--CAMBIA TABLA DE STOCKS
UPDATE Stock 
SET [CodAlmacen] = @CodAlmacenNuevo 
WHERE CodAlmacen = @CodAlmacenAnterior

--CAMBIA TABLA DE STOCKS MENSUALES
UPDATE StockMensual 
SET [CodAlmacen] = @CodAlmacenNuevo 
WHERE CodAlmacen = @CodAlmacenAnterior

--CAMBIA TABLA DE COMPRAS
UPDATE Compras 
SET [CodAlmacen] = @CodAlmacenNuevo 
WHERE CodAlmacen = @CodAlmacenAnterior

--CAMBIA TABLA DE VENTAS
UPDATE Ventas 
SET [CodAlmacen] = @CodAlmacenNuevo 
WHERE CodAlmacen = @CodAlmacenAnterior

--CAMBIA TABLA DE GUIAS
UPDATE GuiasRemision 
SET [CodAlmacen] = @CodAlmacenNuevo 
WHERE CodAlmacen = @CodAlmacenAnterior

--CAMBIA TABLA DE ReciboPagos
UPDATE ReciboPagos 
SET [CodAlmacen] = @CodAlmacenNuevo 
WHERE CodAlmacen = @CodAlmacenAnterior

--CAMBIA TABLA DE NotaCredito
UPDATE NotaCredito 
SET [CodAlmacen] = @CodAlmacenNuevo 
WHERE CodAlmacen = @CodAlmacenAnterior

--CAMBIA TABLA DE NotaDebito
UPDATE NotaDebito 
SET [CodAlmacen] = @CodAlmacenNuevo 
WHERE CodAlmacen = @CodAlmacenAnterior

--CAMBIA TABLA DE USUARIOS-ALMACEN
UPDATE UsuarioAlmacen 
SET [CodAlmacen] = @CodAlmacenNuevo 
WHERE CodAlmacen = @CodAlmacenAnterior

--CAMBIA TABLA DE INVENTARIO INICIAL
UPDATE InventarioInicial
SET [CodAlmacen] = @CodAlmacenNuevo
WHERE CodAlmacen = @CodAlmacenAnterior

--CAMBIA TABLA DE ENTRADASTRASLADO
UPDATE EntradaTraslado
SET [CodAlmacen] = @CodAlmacenNuevo
WHERE CodAlmacen = @CodAlmacenAnterior

--CAMBIA TABLA DE OrdenCompra
UPDATE OrdenCompra
SET [CodAlmacen] = @CodAlmacenNuevo 
WHERE CodAlmacen = @CodAlmacenAnterior

--CAMBIA TABLA DE RequerimientoAlmacen
UPDATE RequerimientoAlmacen
SET [CodAlmacen] = @CodAlmacenNuevo 
WHERE CodAlmacen = @CodAlmacenAnterior

--CAMBIA TABLA DE TomaInventario
UPDATE TomaInventario
SET [CodAlmacen] = @CodAlmacenNuevo 
WHERE CodAlmacen = @CodAlmacenAnterior

--CAMBIA TABLA DE PagosProveedor
UPDATE PagosProveedor
SET [CodAlmacen] = @CodAlmacenNuevo 
WHERE CodAlmacen = @CodAlmacenAnterior

--CAMBIA TABLA DE Proforma
UPDATE Proforma
SET [CodAlmacen] = @CodAlmacenNuevo 
WHERE CodAlmacen = @CodAlmacenAnterior

--CAMBIA TABLA DE Convenio
UPDATE Convenio
SET [CodAlmacen] = @CodAlmacenNuevo 
WHERE CodAlmacen = @CodAlmacenAnterior

--CAMBIA TABLA DE RecibosIngresoEgreso
UPDATE RecibosIngresoEgreso
SET [CodAlmacen] = @CodAlmacenNuevo 
WHERE CodAlmacen = @CodAlmacenAnterior

--CAMBIA TABLA DE Pedidos
UPDATE Pedidos
SET [CodAlmacen] = @CodAlmacenNuevo 
WHERE CodAlmacen = @CodAlmacenAnterior

--CAMBIA TABLA DE LogDeleteMov
UPDATE LogDeleteMov
SET [CodAlmacenMov] = @CodAlmacenNuevo 
WHERE CodAlmacenMov = @CodAlmacenAnterior

--CAMBIA TABLA DE Convenio
--UPDATE VPN
--SET [CodAlmacenLocal] = @CodAlmacenNuevo 
--WHERE CodAlmacenLocal = @CodAlmacenAnterior

--BORRA ALMACEN ANTERIOR
DELETE FROM Almacen 
WHERE CodAlmacen = @CodAlmacenAnterior

GO