USE SCOMGER
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[USP_ADM_USUARIO_LOGIN]') AND type in (N'P', N'PC'))
    DROP PROCEDURE [dbo].[USP_ADM_USUARIO_LOGIN]
GO

CREATE PROCEDURE USP_ADM_USUARIO_LOGIN
    @IdUsuario VARCHAR(20),
    @Contrasena VARCHAR(100)
AS
BEGIN
    SET NOCOUNT ON;

    -- Buscar el usuario en la tabla Usuarios, verificar la contraseña y que esté activo
    SELECT IdUsuario, Descripcion, Estado
    FROM Usuarios
    WHERE IdUsuario = @IdUsuario
      AND Contrasena = @Contrasena
      AND Estado = 'A';
END;
GO
