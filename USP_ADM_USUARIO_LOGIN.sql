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

    DECLARE @Estado VARCHAR(1);
    DECLARE @ContrasenaHash VARCHAR(100);
    
    -- Obtiene el estado del usuario y la contraseña hasheada
    SELECT @Estado = Estado, @ContrasenaHash = Contrasena
    FROM Usuarios
    WHERE IdUsuario = @IdUsuario;

    -- Verifica si el usuario existe
    IF @Estado IS NULL
    BEGIN
        RETURN -1; -- Usuario no encontrado
    END

    -- Verifica el estado del usuario
    IF @Estado != 'A'
    BEGIN
        RETURN -2; -- Usuario no activo
    END

    -- Devuelve el hash de la contraseña para que pueda ser verificado en el código C#
    SELECT @ContrasenaHash AS ContrasenaHash;
END;
GO
