USE SCOMGER
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[USP_VentasPorLinea_SEL]') AND type in (N'P', N'PC'))
    DROP PROCEDURE [dbo].[USP_VentasPorLinea_SEL]
GO
CREATE PROCEDURE USP_VentasPorLinea_SEL
    @MesInicio int,
    @MesFin int,
    @Ano int,
    @IdSucursal varchar(3) = NULL,  
    @IdEmpleado varchar(3) = NULL  
AS
BEGIN
    SET NOCOUNT ON;

    SELECT DL.Descripcion AS 'x', 
           SUM(D.SubTotal) AS 'y',
           DL.Descripcion + ' ' + CAST(SUM(D.SubTotal) AS Varchar(20)) AS 'Text'
    FROM Datos D
    INNER JOIN DimLinea DL ON D.IdLinea = DL.IdLinea
    INNER JOIN DimTiempo DT ON D.IdTiempo = DT.IdTiempo
    /* WHERE (D.IdSucursal = @IdSucursal OR @IdSucursal IS NULL)
       AND (D.IdEmpleado = @IdEmpleado OR @IdEmpleado IS NULL)
       AND DT.Mes BETWEEN @MesInicio AND @MesFin
       AND DT.Ano = @Ano */
    GROUP BY DL.Descripcion;
END
GO
