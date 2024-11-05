USE SCOMGER
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[USP_ADM_USUARIO_SEL]') AND type in (N'P', N'PC'))
    DROP PROCEDURE [dbo].[USP_ADM_USUARIO_SEL]
GO

CREATE PROCEDURE USP_ADM_USUARIO_SEL
    @IdUsuario VARCHAR(20)
AS
BEGIN
    SET NOCOUNT ON;

   SELECT 
    IdUsuario,
    Descripcion,
    Contrasena,
    Estado,
    FechaCreacion -- Agregar esta columna si existe en la tabla
FROM 
    Usuarios
WHERE 
    IdUsuario = @IdUsuario;

END

