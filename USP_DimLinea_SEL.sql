USE SCOMGER
GO
CREATE PROCEDURE USP_DimLinea_SEL
AS
BEGIN
SET NOCOUNT OFF
    SELECT IdLinea, Descripcion
    FROM DimLinea WITH (NOLOCK) ;
END
GO
