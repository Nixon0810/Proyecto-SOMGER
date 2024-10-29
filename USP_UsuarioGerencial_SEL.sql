USE SCOMGER
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[USP_Usuarios_SEL]') AND type in (N'P', N'PC'))
    DROP PROCEDURE [dbo].[USP_Usuarios_SEL]
GO
CREATE PROCEDURE USP_Usuarios_SEL
    @IdUsuario VARCHAR(50),
    @Contraseña VARCHAR(100)
AS
BEGIN
    SET NOCOUNT ON;
    
    SELECT IdUsuario, Descipcion, Estado
    FROM Usuarios WITH (NOLOCK)
    WHERE IdUsuario = @Usuario AND Contrasena = @Contraseña AND Estado='A';
END
GO
