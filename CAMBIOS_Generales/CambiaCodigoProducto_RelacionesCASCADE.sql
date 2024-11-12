/*Cambia relacion Productos-UnidadVenta*/
IF  EXISTS (SELECT * FROM sys.foreign_keys 
			WHERE object_id = OBJECT_ID(N'[dbo].[FK__UnidadVen__CodPr__43A1D464]') AND 
			parent_object_id = OBJECT_ID(N'[dbo].[UnidadVenta]'))
	ALTER TABLE UnidadVenta 
	DROP CONSTRAINT FK__UnidadVen__CodPr__43A1D464;
GO
IF  NOT EXISTS (SELECT * FROM sys.foreign_keys 
			WHERE object_id = OBJECT_ID(N'[dbo].[FK_Producto_UnidadVenta]') AND 
			parent_object_id = OBJECT_ID(N'[dbo].[UnidadVenta]'))
	ALTER TABLE UnidadVenta
	ADD CONSTRAINT FK_Producto_UnidadVenta 
	FOREIGN KEY(CodProducto) 
	REFERENCES Producto(CodProducto)
	ON UPDATE CASCADE; --ON DELETE CASCADE;
GO

/*Cambia relacion UnidadVenta-DetalleInventarioInicial*/		
IF  EXISTS (SELECT * FROM sys.foreign_keys 
			WHERE object_id = OBJECT_ID(N'[dbo].[FK__DetalleInventari__436CCA3A]') AND 
			parent_object_id = OBJECT_ID(N'[dbo].[DetalleInventarioInicial]'))
	ALTER TABLE DetalleInventarioInicial
	DROP CONSTRAINT FK__DetalleInventari__436CCA3A;
GO
IF  NOT EXISTS (SELECT * FROM sys.foreign_keys 
			WHERE object_id = OBJECT_ID(N'[dbo].[FK_UnidadVenta_DetalleInventarioInicial]') AND 
			parent_object_id = OBJECT_ID(N'[dbo].[DetalleInventarioInicial]'))
	ALTER TABLE DetalleInventarioInicial
	ADD CONSTRAINT FK_UnidadVenta_DetalleInventarioInicial
	FOREIGN KEY(CodProducto, CodUnidadMedida) 
	REFERENCES UnidadVenta(CodProducto, CodUnidadMedida)
	ON UPDATE CASCADE;
GO

/*Cambia relacion UnidadVenta-DetalleCompras*/	
IF  EXISTS (SELECT * FROM sys.foreign_keys 
			WHERE object_id = OBJECT_ID(N'[dbo].[FK__DetalleCompras__1A6AB4A7]') AND 
			parent_object_id = OBJECT_ID(N'[dbo].[DetalleCompras]'))
	ALTER TABLE DetalleCompras
	DROP CONSTRAINT FK__DetalleCompras__1A6AB4A7;
GO	
IF  NOT EXISTS (SELECT * FROM sys.foreign_keys 
			WHERE object_id = OBJECT_ID(N'[dbo].[FK_UnidadVenta_DetalleCompras]') AND 
			parent_object_id = OBJECT_ID(N'[dbo].[DetalleCompras]'))
	ALTER TABLE DetalleCompras
	ADD CONSTRAINT FK_UnidadVenta_DetalleCompras
	FOREIGN KEY(CodProducto, CodUnidadMedida) 
	REFERENCES UnidadVenta(CodProducto, CodUnidadMedida)
	ON UPDATE CASCADE;	
GO

/*Cambia relacion UnidadVenta-DetalleEntradatraslado*/	
IF  EXISTS (SELECT * FROM sys.foreign_keys 
			WHERE object_id = OBJECT_ID(N'[dbo].[FK__DetalleEntradaTr__50FBCF82]') AND 
			parent_object_id = OBJECT_ID(N'[dbo].[DetalleEntradatraslado]'))
	ALTER TABLE DetalleEntradatraslado
	DROP CONSTRAINT FK__DetalleEntradaTr__50FBCF82;
GO
IF  NOT EXISTS (SELECT * FROM sys.foreign_keys 
			WHERE object_id = OBJECT_ID(N'[dbo].[FK_UnidadVenta_DetalleEntradatraslado]') AND 
			parent_object_id = OBJECT_ID(N'[dbo].[DetalleEntradatraslado]'))
	ALTER TABLE DetalleEntradatraslado
	ADD CONSTRAINT FK_UnidadVenta_DetalleEntradatraslado
	FOREIGN KEY(CodProducto, CodUnidadMedida) 
	REFERENCES UnidadVenta(CodProducto, CodUnidadMedida)
	ON UPDATE CASCADE;	
GO

/*Cambia relacion UnidadVenta-DetalleGuiasRemision*/	
IF  EXISTS (SELECT * FROM sys.foreign_keys 
			WHERE object_id = OBJECT_ID(N'[dbo].[FK__DetalleGuiasRemi__0D10B989]') AND 
			parent_object_id = OBJECT_ID(N'[dbo].[DetalleGuiasRemision]'))
	ALTER TABLE DetalleGuiasRemision
	DROP CONSTRAINT FK__DetalleGuiasRemi__0D10B989;
GO
IF  NOT EXISTS (SELECT * FROM sys.foreign_keys 
			WHERE object_id = OBJECT_ID(N'[dbo].[FK_UnidadVenta_DetalleGuiasRemision]') AND 
			parent_object_id = OBJECT_ID(N'[dbo].[DetalleGuiasRemision]'))
	ALTER TABLE DetalleGuiasRemision
	ADD CONSTRAINT FK_UnidadVenta_DetalleGuiasRemision
	FOREIGN KEY(CodProducto, CodUnidadMedida) 
	REFERENCES UnidadVenta(CodProducto, CodUnidadMedida)
	ON UPDATE CASCADE;	
GO

/*Cambia relacion UnidadVenta-DetalleVentas*/	
IF  EXISTS (SELECT * FROM sys.foreign_keys 
			WHERE object_id = OBJECT_ID(N'[dbo].[FK__DetalleVentas__3612CF1C]') AND 
			parent_object_id = OBJECT_ID(N'[dbo].[DetalleVentas]'))
	ALTER TABLE DetalleVentas
	DROP CONSTRAINT FK__DetalleVentas__3612CF1C;
GO
IF  NOT EXISTS (SELECT * FROM sys.foreign_keys 
			WHERE object_id = OBJECT_ID(N'[dbo].[FK_UnidadVenta_DetalleVentas]') AND 
			parent_object_id = OBJECT_ID(N'[dbo].[DetalleVentas]'))	
	ALTER TABLE DetalleVentas
	ADD CONSTRAINT FK_UnidadVenta_DetalleVentas
	FOREIGN KEY(CodProducto, CodUnidadMedida) 
	REFERENCES UnidadVenta(CodProducto, CodUnidadMedida)
	ON UPDATE CASCADE;		
GO

/*Cambia relacion UnidadVenta-DetalleConvenio*/	
/*ALTER TABLE DetalleConvenio
	DROP CONSTRAINT FK_UnidadVenta_DetalleConvenio;*/
IF  NOT EXISTS (SELECT * FROM sys.foreign_keys 
			WHERE object_id = OBJECT_ID(N'[dbo].[FK_UnidadVenta_DetalleConvenio]') AND 
			parent_object_id = OBJECT_ID(N'[dbo].[DetalleConvenio]'))		
	ALTER TABLE DetalleConvenio
	ADD CONSTRAINT FK_UnidadVenta_DetalleConvenio
	FOREIGN KEY(CodProducto, CodUnidadMedida) 
	REFERENCES UnidadVenta(CodProducto, CodUnidadMedida)
	ON UPDATE CASCADE;	
GO

/*Cambia relacion UnidadVenta-DetalleNotaCredito*/	
IF  EXISTS (SELECT * FROM sys.foreign_keys 
			WHERE object_id = OBJECT_ID(N'[dbo].[FK_DetalleNotaCredito_UnidadVenta]') AND 
			parent_object_id = OBJECT_ID(N'[dbo].[DetalleNotaCredito]'))
	ALTER TABLE DetalleNotaCredito
	DROP CONSTRAINT FK_DetalleNotaCredito_UnidadVenta;
GO
IF  NOT EXISTS (SELECT * FROM sys.foreign_keys 
			WHERE object_id = OBJECT_ID(N'[dbo].[FK_UnidadVenta_DetalleNotaCredito]') AND 
			parent_object_id = OBJECT_ID(N'[dbo].[DetalleNotaCredito]'))		
	ALTER TABLE DetalleNotaCredito
	ADD CONSTRAINT FK_UnidadVenta_DetalleNotaCredito
	FOREIGN KEY(CodProducto, CodUnidadMedida) 
	REFERENCES UnidadVenta(CodProducto, CodUnidadMedida)
	ON UPDATE CASCADE;
GO	
--Fix.
IF  NOT EXISTS (SELECT * FROM sys.foreign_keys 
			WHERE object_id = OBJECT_ID(N'[dbo].[FK_NotaCredito_DetalleNotaCredito]') AND 
			parent_object_id = OBJECT_ID(N'[dbo].[DetalleNotaCredito]'))	
	ALTER TABLE DetalleNotaCredito
	ADD CONSTRAINT FK_NotaCredito_DetalleNotaCredito
	FOREIGN KEY(TransNotaCredito) 
	REFERENCES NotaCredito(TransNotaCredito);
GO
	
/*Cambia relacion UnidadVenta-DetalleOrdenCompra*/	
/*ALTER TABLE DetalleOrdenCompra
	DROP CONSTRAINT FK_UnidadVenta_DetalleOrdenCompra;*/
IF  NOT EXISTS (SELECT * FROM sys.foreign_keys 
			WHERE object_id = OBJECT_ID(N'[dbo].[FK_UnidadVenta_DetalleOrdenCompra]') AND 
			parent_object_id = OBJECT_ID(N'[dbo].[DetalleOrdenCompra]'))	
	ALTER TABLE DetalleOrdenCompra
	ADD CONSTRAINT FK_UnidadVenta_DetalleOrdenCompra
	FOREIGN KEY(CodProducto, CodUnidadMedida) 
	REFERENCES UnidadVenta(CodProducto, CodUnidadMedida)
	ON UPDATE CASCADE;
GO

/*Cambia relacion UnidadVenta-DetallePedido*/	
IF  EXISTS (SELECT * FROM sys.foreign_keys 
			WHERE object_id = OBJECT_ID(N'[dbo].[FK__DetallePedido__78159CA3]') AND 
			parent_object_id = OBJECT_ID(N'[dbo].[DetallePedido]'))
	ALTER TABLE DetallePedido
	DROP CONSTRAINT FK__DetallePedido__78159CA3;
GO
IF  NOT EXISTS (SELECT * FROM sys.foreign_keys 
			WHERE object_id = OBJECT_ID(N'[dbo].[FK_UnidadVenta_DetallePedido]') AND 
			parent_object_id = OBJECT_ID(N'[dbo].[DetallePedido]'))
	ALTER TABLE DetallePedido
	ADD CONSTRAINT FK_UnidadVenta_DetallePedido
	FOREIGN KEY(CodProducto, CodUnidadMedida) 
	REFERENCES UnidadVenta(CodProducto, CodUnidadMedida)
	ON UPDATE CASCADE;
GO

/*Cambia relacion UnidadVenta-DetalleProforma*/	
/*ALTER TABLE DetalleProforma
	DROP CONSTRAINT FK_UnidadVenta_DetalleProforma;*/
IF  NOT EXISTS (SELECT * FROM sys.foreign_keys 
			WHERE object_id = OBJECT_ID(N'[dbo].[FK_UnidadVenta_DetalleProforma]') AND 
			parent_object_id = OBJECT_ID(N'[dbo].[DetalleProforma]'))	
	ALTER TABLE DetalleProforma
	ADD CONSTRAINT FK_UnidadVenta_DetalleProforma
	FOREIGN KEY(CodProducto, CodUnidadMedida) 
	REFERENCES UnidadVenta(CodProducto, CodUnidadMedida)
	ON UPDATE CASCADE;
GO

/*Cambia relacion UnidadVenta-DetalleTomaInventario*/	
IF  EXISTS (SELECT * FROM sys.foreign_keys 
			WHERE object_id = OBJECT_ID(N'[dbo].[PK_TomaInventario_DetalleTomaInventario]') AND 
			parent_object_id = OBJECT_ID(N'[dbo].[DetalleTomaInventario]'))
	ALTER TABLE DetalleTomaInventario
	DROP CONSTRAINT PK_TomaInventario_DetalleTomaInventario;
GO
IF  NOT EXISTS (SELECT * FROM sys.foreign_keys 
			WHERE object_id = OBJECT_ID(N'[dbo].[FK_UnidadVenta_DetalleTomaInventario]') AND 
			parent_object_id = OBJECT_ID(N'[dbo].[DetalleTomaInventario]'))
	ALTER TABLE DetalleTomaInventario
	ADD CONSTRAINT FK_UnidadVenta_DetalleTomaInventario
	FOREIGN KEY(CodProducto, CodUnidadMedida) 
	REFERENCES UnidadVenta(CodProducto, CodUnidadMedida)
	ON UPDATE CASCADE;
GO	
--Fix.	
IF  NOT EXISTS (SELECT * FROM sys.foreign_keys 
			WHERE object_id = OBJECT_ID(N'[dbo].[FK_TomaInventario_DetalleTomaInventario]') AND 
			parent_object_id = OBJECT_ID(N'[dbo].[DetalleTomaInventario]'))
	ALTER TABLE DetalleTomaInventario
	ADD CONSTRAINT FK_TomaInventario_DetalleTomaInventario
	FOREIGN KEY(TransTomaInventario) 
	REFERENCES TomaInventario(TransTomaInventario);
GO

/*Cambia relacion Producto-StockMensual*/	
/*ALTER TABLE StockMensual
	DROP CONSTRAINT FK_Producto_StockMensual*/;
IF  NOT EXISTS (SELECT * FROM sys.foreign_keys 
			WHERE object_id = OBJECT_ID(N'[dbo].[FK_Producto_StockMensual]') AND 
			parent_object_id = OBJECT_ID(N'[dbo].[StockMensual]'))	
	ALTER TABLE StockMensual
	ADD CONSTRAINT FK_Producto_StockMensual
	FOREIGN KEY(CodProducto) 
	REFERENCES Producto(CodProducto)
	ON UPDATE CASCADE;
GO

/*Cambia relacion Producto-ProductoDerivados*/	
/*ALTER TABLE ProductoDerivados
	DROP CONSTRAINT FK_Producto_ProductoDerivados*/;
IF  NOT EXISTS (SELECT * FROM sys.foreign_keys 
			WHERE object_id = OBJECT_ID(N'[dbo].[FK_Producto_ProductoDerivados_Principal]') AND 
			parent_object_id = OBJECT_ID(N'[dbo].[ProductoDerivados]'))		
	ALTER TABLE ProductoDerivados
	ADD CONSTRAINT FK_Producto_ProductoDerivados_Principal
	FOREIGN KEY(CodProductoPrincipal) 
	REFERENCES Producto(CodProducto)
	ON UPDATE CASCADE;
GO
IF  NOT EXISTS (SELECT * FROM sys.foreign_keys 
			WHERE object_id = OBJECT_ID(N'[dbo].[FK_Producto_ProductoDerivados_Derivado]') AND 
			parent_object_id = OBJECT_ID(N'[dbo].[ProductoDerivados]'))		
	ALTER TABLE ProductoDerivados
	ADD CONSTRAINT FK_Producto_ProductoDerivados_Derivado
	FOREIGN KEY(CodProductoDerivado) 
	REFERENCES Producto(CodProducto)
	ON UPDATE NO ACTION;
GO	

/*Cambia relacion Producto-ProductoRptOrden*/	
/*ALTER TABLE ProductoRptOrden
	DROP CONSTRAINT FK_Producto_ProductoRptOrden*/;
IF  NOT EXISTS (SELECT * FROM sys.foreign_keys 
			WHERE object_id = OBJECT_ID(N'[dbo].[FK_Producto_ProductoRptOrden]') AND 
			parent_object_id = OBJECT_ID(N'[dbo].[ProductoRptOrden]'))		
	ALTER TABLE ProductoRptOrden
	ADD CONSTRAINT FK_Producto_ProductoRptOrden
	FOREIGN KEY(CodProducto) 
	REFERENCES Producto(CodProducto)
	ON UPDATE CASCADE;
GO

/*Cambia relacion Producto-Stock*/	
/*ALTER TABLE Stock
	DROP CONSTRAINT FK_Producto_Stock*/;
IF  NOT EXISTS (SELECT * FROM sys.foreign_keys 
			WHERE object_id = OBJECT_ID(N'[dbo].[FK_Producto_Stock]') AND 
			parent_object_id = OBJECT_ID(N'[dbo].[Stock]'))	
	ALTER TABLE Stock
	ADD CONSTRAINT FK_Producto_Stock
	FOREIGN KEY(CodProducto) 
	REFERENCES Producto(CodProducto)
	ON UPDATE CASCADE;
GO

/*Cambia relacion Producto-StockVendedor*/	
/*ALTER TABLE StockVendedor
	DROP CONSTRAINT FK_Producto_StockVendedor*/;
IF  NOT EXISTS (SELECT * FROM sys.foreign_keys 
			WHERE object_id = OBJECT_ID(N'[dbo].[FK_Producto_StockVendedor]') AND 
			parent_object_id = OBJECT_ID(N'[dbo].[StockVendedor]'))		
	ALTER TABLE StockVendedor
	ADD CONSTRAINT FK_Producto_StockVendedor
	FOREIGN KEY(CodProducto) 
	REFERENCES Producto(CodProducto)
	ON UPDATE CASCADE;
GO

/*Cambia relacion Producto-producto_capacidad*/	
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[producto_capacidad]') AND type in (N'U'))
BEGIN
	IF  EXISTS (SELECT * FROM sys.foreign_keys 
				WHERE object_id = OBJECT_ID(N'[dbo].[producto_capacidad_codproducto_foreign]') AND 
				parent_object_id = OBJECT_ID(N'[dbo].[producto_capacidad]'))
		ALTER TABLE producto_capacidad
		DROP CONSTRAINT producto_capacidad_codproducto_foreign;
	
	IF  NOT EXISTS (SELECT * FROM sys.foreign_keys 
				WHERE object_id = OBJECT_ID(N'[dbo].[producto_capacidad_codproducto_foreign]') AND 
				parent_object_id = OBJECT_ID(N'[dbo].[producto_capacidad]'))		
		ALTER TABLE producto_capacidad
		ADD CONSTRAINT producto_capacidad_codproducto_foreign
		FOREIGN KEY(CodProducto) 
		REFERENCES Producto(CodProducto)
		ON UPDATE CASCADE;
END
GO
