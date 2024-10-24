IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FnFormatoDimTiempo]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
	DROP FUNCTION [dbo].[FnFormatoDimTiempo]
GO

CREATE FUNCTION dbo.FnFormatoDimTiempo(@Fecha Date)
RETURNS Varchar(10)
AS
BEGIN
	DECLARE @Resultado Varchar(10)
	DECLARE @Año Varchar(6), @Mes Varchar(2), @Dia Varchar(2), @DiaSemana Varchar(2)
	SELECT	@Año=DATEPART(YEAR, @Fecha),
			@Mes=REPLICATE(0,2-LEN(DATEPART(MONTH, @Fecha)))+CAST(DATEPART(MONTH, @Fecha) AS Varchar(2)),
			@Dia=REPLICATE(0,2-LEN(DATEPART(DAY, @Fecha)))+CAST(DATEPART(DAY, @Fecha) AS Varchar(2)),
			@DiaSemana=REPLICATE(0,2-LEN(DATEPART(WEEKDAY, @Fecha)))+CAST(DATEPART(WEEKDAY, @Fecha) AS Varchar(2))

	SET @Resultado= @Año+@Mes+@Dia+@DiaSemana
	RETURN @Resultado
END
GO

