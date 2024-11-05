USE SCOMGER
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[USP_ADM_USUARIO_INS]') AND type in (N'P', N'PC'))
    DROP PROCEDURE [dbo].[USP_ADM_USUARIO_INS]
GO

CREATE PROCEDURE USP_ADM_USUARIO_INS
    @IdUsuario VARCHAR(20),
    @Descripcion VARCHAR(50) = NULL,
	@FechaCreacion DateTime,
    @Contrasena VARCHAR(100),
    @Estado VARCHAR(1) = 'A'
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO Usuarios (IdUsuario, Descripcion,FechaCreacion, Contrasena, Estado)
    VALUES (@IdUsuario, @Descripcion, GetDate(), @Contrasena, 'A');
END;
GO