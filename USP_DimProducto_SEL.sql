USE SCOMGER
GO
CREATE PROCEDURE USP_DimProducto_SEL
AS
BEGIN
SET NOCOUNT OFF
    SELECT IdProducto, Descripcion
    FROM DimProducto WITH (NOLOCK) ;
END
GO