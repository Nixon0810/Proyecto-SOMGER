CREATE PROCEDURE PaSCOMGER_JobEmpleado AS
BEGIN
BEGIN TRANSACTION 
	MERGE INTO SCOMGER.dbo.DimEmpleado AS tgt
		USING (SELECT CodEmpleado, Descripcion FROM dbo.Empleado) AS src
	ON (tgt.idEmpleado = src.CodEmpleado)
	WHEN NOT MATCHED THEN
		INSERT  (IdEmpleado, Descripcion)
		VALUES  (src.CodEmpleado, src.Descripcion)
	WHEN MATCHED THEN
		UPDATE SET tgt.Descripcion = src.Descripcion           ;
COMMIT TRANSACTION
END
GO
