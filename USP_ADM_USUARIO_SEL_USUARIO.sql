USE SCOMGER
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[USP_ADM_USUARIO_SEL_USUARIO]') AND type in (N'P', N'PC'))
    DROP PROCEDURE [dbo].[USP_ADM_USUARIO_SEL_USUARIO]
GO

CREATE PROCEDURE USP_ADM_USUARIO_SEL_USUARIO
    @IdUsuario VARCHAR(20)
AS
BEGIN
    SET NOCOUNT ON;

    -- Consulta que incluye el campo FechaCreacion si está presente en la tabla
    SELECT 
        IdUsuario,
        Descripcion,
        Contrasena AS ContrasenaHash, -- Nombre como ContrasenaHash para alinearse con el código
        Estado,
        FechaCreacion -- Asegúrate de que esta columna exista en la tabla Usuarios
    FROM 
        Usuarios
    WHERE 
        IdUsuario = @IdUsuario;
END;
GO
