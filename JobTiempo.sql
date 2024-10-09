USE SCOMGER
GO

CREATE PROCEDURE PaSCOMGER_JobTiempo AS
BEGIN
BEGIN TRANSACTION 
	MERGE INTO SCOMGER.dbo.DimTiempo AS tgt
		USING (SELECT CAST(YEAR(FechaVenta) AS Varchar)+
					REPLICATE(0,2-LEN(CAST(MONTH(FechaVenta)AS Varchar)))+CAST(MONTH(FechaVenta)AS Varchar)+
					REPLICATE(0,2-LEN(CAST(DAY(FechaVenta)AS Varchar)))+CAST(DAY(FechaVenta)AS Varchar)+
					REPLICATE(0,2-LEN(CAST(DATEPART(WEEKDAY,FechaVenta)AS Varchar)))+CAST(DATEPART(WEEKDAY,FechaVenta)AS Varchar) AS IdTiempo,
					YEAR(FechaVenta) AS Ano,
					MONTH(FechaVenta)AS Mes,
					DAY(FechaVenta) AS Dia,
					DATEPART(WEEKDAY,FechaVenta) AS DiaSemana
			FROM BDComercial.dbo.Ventas
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
COMMIT TRANSACTION
END
GO