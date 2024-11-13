USE SCOMGER
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[USP_ADM_USUARIO_DEL]') AND type in (N'P', N'PC'))
    DROP PROCEDURE [dbo].[USP_ADM_USUARIO_DEL]
GO

CREATE PROCEDURE USP_ADM_USUARIO_DEL
    @IdUsuario VARCHAR(20)
AS
BEGIN
    SET NOCOUNT ON;

    -- Cambia el estado del usuario a 'I'
    UPDATE Usuarios
    SET Estado = 'I'
    WHERE IdUsuario = @IdUsuario;

    -- Verificar si se actualizó alguna fila
    IF @@ROWCOUNT = 0
    BEGIN
        RETURN -1; -- Usuario no encontrado
    END

    RETURN 0; -- Operación exitosa
END
GO
