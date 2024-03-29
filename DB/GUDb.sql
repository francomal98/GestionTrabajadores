USE [GestionTrabajadores]
GO
/****** Object:  Table [dbo].[Jwt_Types]    Script Date: 14/09/2023 10:38:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Jwt_Types](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Descripcion] [nvarchar](65) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[JwtAccounts]    Script Date: 14/09/2023 10:38:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[JwtAccounts](
	[Token] [nvarchar](max) NULL,
	[Identifier] [nvarchar](max) NULL,
	[Id_TipoToken] [int] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TipoTrabajador]    Script Date: 14/09/2023 10:38:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TipoTrabajador](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[TipoTrabajador] [nvarchar](max) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Trabajadores]    Script Date: 14/09/2023 10:38:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Trabajadores](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [nvarchar](max) NOT NULL,
	[ApellidoPaterno] [nvarchar](max) NOT NULL,
	[ApellidoMaterno] [nvarchar](max) NOT NULL,
	[FechaCumpleanos] [datetime] NOT NULL,
	[FechaContratacion] [datetime] NOT NULL,
	[Telefono] [nvarchar](max) NOT NULL,
	[Email] [nvarchar](max) NOT NULL,
	[Municipio] [nvarchar](max) NOT NULL,
	[Estado] [nvarchar](max) NOT NULL,
	[TipoTrabajador] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Trabajadores_Usuario]    Script Date: 14/09/2023 10:38:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Trabajadores_Usuario](
	[Id_Usuario] [int] NOT NULL,
	[Id_Trabajador] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Usuarios]    Script Date: 14/09/2023 10:38:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Usuarios](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Usuario] [nvarchar](max) NULL,
	[ApellidoMaterno] [nvarchar](max) NULL,
	[ApellidoPaterno] [nvarchar](max) NULL,
	[Correo] [nvarchar](max) NULL,
	[Contraseña] [nvarchar](max) NULL,
	[ConfirmacionCuenta] [bit] NULL,
	[FechaRegistro] [datetime] NULL,
	[Nombre] [nvarchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[JwtAccounts]  WITH CHECK ADD FOREIGN KEY([Id_TipoToken])
REFERENCES [dbo].[Jwt_Types] ([Id])
GO
ALTER TABLE [dbo].[Trabajadores]  WITH CHECK ADD FOREIGN KEY([TipoTrabajador])
REFERENCES [dbo].[TipoTrabajador] ([Id])
GO
/****** Object:  StoredProcedure [dbo].[STP_ACCOUNTSIGNUP]    Script Date: 14/09/2023 10:38:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[STP_ACCOUNTSIGNUP]
@usuario nvarchar(max),
@nombre nvarchar(max),
@apellidoP nvarchar(max),
@apellidoM nvarchar(max),
@correo nvarchar(max),
@contrasena nvarchar(max),
@token nvarchar(max),
@identificador nvarchar(max)
AS
	BEGIN
		DECLARE @error NVARCHAR(MAX)

		IF (SELECT COUNT(*) FROM Usuarios AS us WHERE us.Usuario = @usuario COLLATE SQL_Latin1_General_CP1_CS_AS) = 0 
			BEGIN
				IF (SELECT COUNT(*) FROM Usuarios AS us WHERE us.Correo = @correo) = 0
					BEGIN
						INSERT INTO Usuarios(Usuario, ApellidoMaterno, ApellidoPaterno, Correo, Contraseña, 
							ConfirmacionCuenta, FechaRegistro, Nombre) VALUES (@usuario, @apellidoP, @apellidoM, @correo, @contrasena, 0, GETDATE(), @nombre);
						INSERT INTO JwtAccounts (Token, Identifier, Id_TipoToken) VALUES (@token, @identificador, 2);
					END
				ELSE
					BEGIN
						SET @error = CONCAT('El correo ', @correo, ' ya existe. Favor de ingresar otro correo electronico.');
						RAISERROR(@error, 16, 1);
					END
			END
		ELSE 
			BEGIN
				SET @error = CONCAT('El usuario ', @usuario, ' ya existe. Favor de ingresar otro usuario.');
				RAISERROR(@error, 16, 1);
			END
	END

GO
/****** Object:  StoredProcedure [dbo].[STP_ACTIVATEUSERACCOUNT]    Script Date: 14/09/2023 10:38:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[STP_ACTIVATEUSERACCOUNT]
@username NVARCHAR(MAX)
AS
	BEGIN
		UPDATE Usuarios SET ConfirmacionCuenta = 1 WHERE Usuario = @username COLLATE SQL_Latin1_General_CP1_CS_AS;
	END
GO
/****** Object:  StoredProcedure [dbo].[STP_ADDNEWORKER]    Script Date: 14/09/2023 10:38:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[STP_ADDNEWORKER]
@userid INT,
@nombre NVARCHAR(MAX),
@apellidoP NVARCHAR(MAX),
@apellidoM NVARCHAR(MAX),
@fechaCumpleanos DATETIME,
@fechaContratacon DATETIME,
@telefono NVARCHAR(MAX),
@email NVARCHAR(MAX),
@estado NVARCHAR(MAX),
@municipio NVARCHAR(MAX),
@tipotrabajador INT
AS 
	BEGIN
		DECLARE @idInsert INT;

		INSERT Trabajadores (Nombre, ApellidoPaterno, 
			ApellidoMaterno, FechaCumpleanos, FechaContratacion, Telefono, Email, Municipio,
			Estado, TipoTrabajador)
			VALUES (@nombre, @apellidoP, @apellidoM, @fechaCumpleanos, @fechaContratacon, @telefono,
				@email, @municipio, @estado, @tipotrabajador)
			SET @idInsert = @@IDENTITY

			INSERT INTO Trabajadores_Usuario(Id_Usuario, Id_Trabajador)
			VALUES (@userid, @idInsert);

	END
GO
/****** Object:  StoredProcedure [dbo].[STP_DELETEACCOUNT]    Script Date: 14/09/2023 10:38:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[STP_DELETEACCOUNT]
@Userid nvarchar(25)
AS
	BEGIN
		DELETE FROM Usuarios WHERE Id = @Userid;
	END
GO
/****** Object:  StoredProcedure [dbo].[STP_GETLOGININFO]    Script Date: 14/09/2023 10:38:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[STP_GETLOGININFO]
@usuario nvarchar(max)
AS
	BEGIN
		DECLARE @errorMessage nvarchar(max);
		IF(SELECT COUNT(*) FROM Usuarios as us WHERE us.Usuario = @usuario COLLATE SQL_Latin1_General_CP1_CS_AS) = 1
			BEGIN
				SELECT us.Id, us.Usuario, us.Contraseña FROM Usuarios AS us;
			END
		ELSE 
			BEGIN
				SET @errorMessage = CONCAT('No existe registrado el usuario ', @usuario);
				RAISERROR(@errorMessage, 16, 1);
			END
	END
GO
/****** Object:  StoredProcedure [dbo].[STP_GETTOKENBYIDENTIFIER]    Script Date: 14/09/2023 10:38:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[STP_GETTOKENBYIDENTIFIER]
@identificador NVARCHAR(MAX),
@toketype INT
AS
	BEGIN
		SELECT jw.Token FROM JwtAccounts as jw
		WHERE jw.Identifier = @identificador AND jw.Id_TipoToken = @toketype
	END
GO
/****** Object:  StoredProcedure [dbo].[STP_GETWORKERBYUSER]    Script Date: 14/09/2023 10:38:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[STP_GETWORKERBYUSER]
@userId int
AS
	BEGIN
		SELECT CONCAT(tb.Nombre, ' ', tb.ApellidoPaterno, ' ', tb.ApellidoMaterno) AS NombreCompleto,
		tb.FechaCumpleanos, tb.Email, tb.Telefono, tt.TipoTrabajador
		FROM Trabajadores_Usuario AS tu
		INNER JOIN Trabajadores as tb ON tu.Id_Trabajador = tb.Id
		INNER JOIN TipoTrabajador AS tt ON tt.Id = tb.TipoTrabajador
		WHERE tu.Id_Usuario = @userId
	END
GO
/****** Object:  StoredProcedure [dbo].[STP_INSERTTOKENDB]    Script Date: 14/09/2023 10:38:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[STP_INSERTTOKENDB]
@token NVARCHAR(MAX),
@identificador NVARCHAR(MAX),
@toketype INT
AS
	BEGIN
		INSERT INTO JwtAccounts(Token, Identifier, Id_TipoToken)
		VALUES (@token, @identificador, @toketype)
	END
GO
/****** Object:  StoredProcedure [dbo].[STP_UPDATEACCOUNTINFO]    Script Date: 14/09/2023 10:38:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[STP_UPDATEACCOUNTINFO]
@userid integer,
@username nvarchar(max) = null,
@nombre nvarchar(max) = null,
@apellidomat nvarchar(max) = null,
@apellidopat nvarchar(max) = null
AS
	BEGIN
		DECLARE @error nvarchar(max);
		IF(SELECT COUNT(*) FROM Usuarios WHERE Usuario = @username COLLATE SQL_Latin1_General_CP1_CS_AS) > 0
			BEGIN
				SET @error = 'El nombre de usuario ya existe. Favor de seleccionar otro.'
				RAISERROR(@error, 16, 1)
			END
		ELSE 
			BEGIN
				UPDATE Usuarios 
				SET
					Usuario = CASE WHEN @username IS NOT NULL THEN @username ELSE Usuario END,
					Nombre = CASE WHEN @nombre IS NOT NULL THEN @nombre ELSE Nombre END,
					ApellidoPaterno = CASE WHEN @apellidopat IS NOT NULL THEN @apellidopat ELSE ApellidoPaterno END,
					ApellidoMaterno = CASE WHEN @apellidomat IS NOT NULL THEN @apellidomat ELSE ApellidoMaterno END
				WHERE Id = @userid;
			END
	END
GO
/****** Object:  StoredProcedure [dbo].[STP_UPDATEACCOUNTPASSWORD]    Script Date: 14/09/2023 10:38:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[STP_UPDATEACCOUNTPASSWORD]
@userid nvarchar(max),
@password nvarchar(max)
AS
	BEGIN
		UPDATE Usuarios SET Contraseña = @password WHERE Id = @userid;
	END
GO
