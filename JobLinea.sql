USE SCOMGER
GO

CREATE PROCEDURE PaSCOMGER_JobLinea AS
BEGIN
BEGIN TRANSACTION 
	MERGE INTO SCOMGER.dbo.DimLinea AS tgt
		USING (SELECT CodLinea, Descripcion FROM BDComercial.dbo.Linea) AS src
	ON (tgt.idLinea = src.CodLinea)
	WHEN NOT MATCHED THEN
		INSERT  (IdLinea, Descripcion)
		VALUES  (src.CodLinea, src.Descripcion)
	WHEN MATCHED THEN
	UPDATE SET tgt.Descripcion = src.Descripcion           ;
	COMMIT TRANSACTION
END
GO

