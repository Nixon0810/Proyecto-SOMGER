USE SCOMGER
GO

CREATE PROCEDURE PaSCOMGER_JobMarca AS
BEGIN
	BEGIN TRANSACTION 
		MERGE INTO SCOMGER.dbo.DimMarca AS tgt
			USING (SELECT CodMarca, Descripcion FROM BDComercial.dbo.Marca) AS src
		ON (tgt.idMarca = src.CodMarca)
		WHEN NOT MATCHED THEN
			INSERT  (IdMarca, Descripcion)
			VALUES  (src.CodMarca, src.Descripcion)
		WHEN MATCHED THEN
		UPDATE SET tgt.Descripcion = src.Descripcion           ;
	COMMIT TRANSACTION
END
GO

