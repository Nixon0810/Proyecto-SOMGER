/*  SCRIPT CAMBIA CODIGO DE PRODUCTO X OTRO
  (OJO: No tiene que Existir el Producto nuevo)
*/
SET NOCOUNT ON
DECLARE @CONTROL INT=1
DECLARE @CodProductoActual AS Varchar(8)
DECLARE @CodProductoNuevo AS Varchar(8)

SET @CodProductoActual='T0000454'
SET @CodProductoNuevo ='00000941'
PRINT 'Cambiando Codigo: Actual->'+@CodProductoActual+' Nuevo:'+@CodProductoNuevo

INICAR_PROCESO:

BEGIN TRY
	IF LEFT(@CodProductoActual,1)='T' SET @CONTROL=3
	
	IF NOT EXISTS(SELECT CodProducto FROM Producto WHERE CodProducto=@CodProductoNuevo) BEGIN
		BEGIN TRANSACTION

		INSERT INTO Producto
			(CodProducto, CodLinea, CodMarca, CodUnidadMedidaVtaMinima, Descripcion, ExoneradoIGV, Tipo, StockMinimo, PideDatosCliente, Peso,
			CodGenerico, UbicInternaCol, UbicInternaFila, PartidaArancelaria, Procedencia, UbicInternaCol2, UbicInternaFila2, EsPesable, Estado, 
			FlagVencimiento, FechaVencimiento, AutorellenarDescripcion, Modelo, Color, Talla,CodCategoriaProducto, CodMonedaPrecio,FlagFISE,FactorFISE,
			EsTransferenciaGratuita,EsBonificacion,EsAfectoICBPER, CodFamilia,CodSubFamilia, EcommerceFlag,EcommerceDestacado,EcommerceEnOferta,EcommerceEnLiquidacion,EcommerceEstado,EcommerceMostrarWeb)
		SELECT @CodProductoNuevo, CodLinea, CodMarca, CodUnidadMedidaVtaMinima, Descripcion, ExoneradoIGV, Tipo, StockMinimo, PideDatosCliente, Peso,
			CodGenerico, UbicInternaCol, UbicInternaFila, PartidaArancelaria, Procedencia, UbicInternaCol2, UbicInternaFila2, EsPesable, Estado, 
			FlagVencimiento, FechaVencimiento, AutorellenarDescripcion, Modelo, Color, Talla,CodCategoriaProducto, CodMonedaPrecio,FlagFISE,FactorFISE,
			EsTransferenciaGratuita,EsBonificacion,EsAfectoICBPER, CodFamilia,CodSubFamilia, EcommerceFlag,EcommerceDestacado,EcommerceEnOferta,EcommerceEnLiquidacion,EcommerceEstado,EcommerceMostrarWeb
		FROM Producto 
		WHERE CodProducto = @CodProductoActual

		INSERT INTO UnidadVenta
		(CodProducto, CodUnidadMedida, CantidadAfectarStock, Fraccionable, PrecioPublico, PrecioMayor, PrecioCredito, CodigoBarra, PUtilidad1, PUtilidad2, PUtilidad3, Precio4, Precio5, PUtilidad4, 
		 PUtilidad5, Estado, PDescuento1, PDescuento2, PDescuento3, PDescuento4, PDescuento5)
		SELECT @CodProductoNuevo, CodUnidadMedida, CantidadAfectarStock, Fraccionable, PrecioPublico, PrecioMayor, PrecioCredito, CodigoBarra, PUtilidad1, PUtilidad2, PUtilidad3, Precio4, Precio5, PUtilidad4, 
         PUtilidad5, Estado, PDescuento1, PDescuento2, PDescuento3, PDescuento4, PDescuento5
		FROM UnidadVenta 
		WHERE CodProducto = @CodProductoActual

		UPDATE DetalleInventarioInicial SET CodProducto =@CodProductoNuevo
		WHERE CodProducto = @CodProductoActual

		UPDATE DetalleCompras SET CodProducto =@CodProductoNuevo
		WHERE CodProducto = @CodProductoActual

		UPDATE DetalleEntradatraslado SET CodProducto =@CodProductoNuevo
		WHERE CodProducto = @CodProductoActual

		UPDATE DetalleGuiasRemision SET CodProducto =@CodProductoNuevo
		WHERE CodProducto = @CodProductoActual

		UPDATE DetalleVentas SET CodProducto =@CodProductoNuevo
		WHERE CodProducto = @CodProductoActual

		UPDATE DetalleConvenio SET CodProducto =@CodProductoNuevo
		WHERE CodProducto = @CodProductoActual

		UPDATE DetalleNotaCredito SET CodProducto =@CodProductoNuevo
		WHERE CodProducto = @CodProductoActual

		UPDATE DetalleOrdenCompra SET CodProducto =@CodProductoNuevo
		WHERE CodProducto = @CodProductoActual

		UPDATE DetallePedido SET CodProducto =@CodProductoNuevo
		WHERE CodProducto = @CodProductoActual

		UPDATE DetalleProforma SET CodProducto =@CodProductoNuevo
		WHERE CodProducto = @CodProductoActual

		UPDATE DetalleTomaInventario SET CodProducto =@CodProductoNuevo
		WHERE CodProducto = @CodProductoActual

		UPDATE StockMensual SET CodProducto =@CodProductoNuevo
		WHERE CodProducto = @CodProductoActual

		UPDATE ProductoDerivados SET CodProductoPrincipal =@CodProductoNuevo
		WHERE CodProductoPrincipal = @CodProductoActual

		UPDATE ProductoRptOrden SET CodProducto =@CodProductoNuevo
		WHERE CodProducto = @CodProductoActual

		UPDATE Stock SET CodProducto =@CodProductoNuevo
		WHERE CodProducto = @CodProductoActual

		UPDATE StockVendedor SET CodProducto =@CodProductoNuevo
		WHERE CodProducto = @CodProductoActual				

		UPDATE StockVendedor SET CodProducto =@CodProductoNuevo
		WHERE CodProducto = @CodProductoActual	

		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[producto_capacidad]') AND type in (N'U'))
		BEGIN		
			UPDATE producto_capacidad SET CodProducto =@CodProductoNuevo
			WHERE CodProducto = @CodProductoActual			
		END

		COMMIT TRANSACTION
			
		EXECUTE Sp_EliminarProducto @CodProductoActual, 0
		
		PRINT 'Codigo de Producto Cambiado Correctamente'
	END
	ELSE BEGIN
		IF @CONTROL<=2 BEGIN
				
				SET @CodProductoActual=@CodProductoNuevo
				SET @CodProductoNuevo='T'+RIGHT(@CodProductoNuevo,7)
				PRINT 'Reasignando Codigo Temporal: Actual->'+@CodProductoActual+' Nuevo:'+@CodProductoNuevo
				
				SET @CONTROL=@CONTROL+1
				GOTO INICAR_PROCESO
			END
		ELSE BEGIN
			RAISERROR('Error: Codigo de Producto a crear ya existe',16,1)
		END
	END
END TRY

BEGIN CATCH
	IF (@@TRANCOUNT > 0)  BEGIN
		ROLLBACK TRANSACTION 
	END

	DECLARE @nLinea INT,@cError VARCHAR(8000),@cStored VARCHAR(500)
	SET @nLinea = ERROR_LINE()            
	SET @cError = ERROR_MESSAGE()            

	PRINT 'Linea  :'+CAST(@nLinea AS VARCHAR)
	PRINT 'Mensaje:'+@cError
		
END CATCH
GO
