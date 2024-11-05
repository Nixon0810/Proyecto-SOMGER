USE SCOMGER
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[USP_ADM_USUARIO_UPDATE]') AND type in (N'P', N'PC'))
    DROP PROCEDURE [dbo].[USP_ADM_USUARIO_UPDATE]
GO

CREATE PROCEDURE USP_ADM_USUARIO_UPDATE
    @IdUsuario VARCHAR(20),
    @Descripcion VARCHAR(50) = NULL,
    @FechaCreacion DATETIME = NULL,
    @IdUsuarioCreador VARCHAR(20) = NULL,
    @Contrasena VARCHAR(100) = NULL,
    @Estado VARCHAR(1) = NULL
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE Usuarios
    SET Descripcion = ISNULL(@Descripcion, Descripcion),
        FechaCreacion = ISNULL(@FechaCreacion, FechaCreacion),
        IdUsuarioCreador = ISNULL(@IdUsuarioCreador, IdUsuarioCreador),
        Contrasena = ISNULL(@Contrasena, Contrasena),
        Estado = ISNULL(@Estado, Estado)
    WHERE IdUsuario = @IdUsuario;
END;
GO
