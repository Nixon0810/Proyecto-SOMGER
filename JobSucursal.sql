USE SCOMGER
GO

CREATE PROCEDURE PaSCOMGER_JobSucursal AS
BEGIN
BEGIN TRANSACTION 
	MERGE INTO SCOMGER.dbo.DimSucursal AS tgt
		USING (SELECT CodAlmacen, Descripcion FROM BDComercial.dbo.Almacen) AS src
	ON (tgt.idSucursal = src.CodAlmacen)
	WHEN NOT MATCHED THEN
		INSERT  (IdSucursal, Descripcion)
		VALUES  (src.CodAlmacen, src.Descripcion)
	WHEN MATCHED THEN
	UPDATE SET tgt.Descripcion = src.Descripcion           ;
COMMIT TRANSACTION
END
GO

