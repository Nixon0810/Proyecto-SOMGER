USE SCOMGER
GO

CREATE PROCEDURE PaSCOMGER_JobProducto AS
BEGIN
BEGIN TRANSACTION 
	MERGE INTO SCOMGER.dbo.DimProducto AS tgt
		USING (SELECT CodProducto, Descripcion FROM BDComercial.dbo.Producto) AS src
	ON (tgt.idProducto = src.CodProducto)
	WHEN NOT MATCHED THEN
		INSERT  (IdProducto, Descripcion)
		VALUES  (src.CodProducto, src.Descripcion)
	WHEN MATCHED THEN
	UPDATE SET tgt.Descripcion = src.Descripcion           ;
COMMIT TRANSACTION
END
GO

