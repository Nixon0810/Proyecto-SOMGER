USE SCOMGER
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[USP_ADM_USUARIO_SELECT]') AND type in (N'P', N'PC'))
    DROP PROCEDURE [dbo].[USP_ADM_USUARIO_SELECT]
GO

CREATE PROCEDURE USP_ADM_USUARIO_SELECT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT IdUsuario, Descripcion, FechaCreacion, IdUsuarioCreador, Contrasena, Estado
    FROM Usuarios;
END;
GO
