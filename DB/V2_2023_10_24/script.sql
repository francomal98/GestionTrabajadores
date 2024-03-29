USE [GestionTrabajadores]
GO
/****** Object:  Table [dbo].[Jwt_Types]    Script Date: 24/10/2023 01:30:57 a. m. ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[JwtAccounts]    Script Date: 24/10/2023 01:30:57 a. m. ******/
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
/****** Object:  Table [dbo].[TipoTrabajador]    Script Date: 24/10/2023 01:30:57 a. m. ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Trabajadores]    Script Date: 24/10/2023 01:30:57 a. m. ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Trabajadores_Usuario]    Script Date: 24/10/2023 01:30:57 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Trabajadores_Usuario](
	[Id_Usuario] [int] NOT NULL,
	[Id_Trabajador] [int] NOT NULL,
	[AltaSistema] [datetime] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Usuarios]    Script Date: 24/10/2023 01:30:57 a. m. ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Jwt_Types] ON 

INSERT [dbo].[Jwt_Types] ([Id], [Descripcion]) VALUES (1, N'JWT recuperacion de contrasena')
INSERT [dbo].[Jwt_Types] ([Id], [Descripcion]) VALUES (2, N'JWT registro de usuario')
SET IDENTITY_INSERT [dbo].[Jwt_Types] OFF
GO
INSERT [dbo].[JwtAccounts] ([Token], [Identifier], [Id_TipoToken]) VALUES (N'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJVc2VyTmFtZSI6ImZyYW5jb21hbGZ1IiwibmJmIjoxNjk3OTUzNzE2LCJleHAiOjE2OTc5NTczMTYsImlhdCI6MTY5Nzk1MzcxNn0.i89ENIZrgcrPbVb3MItOb97Rccnwucj6EW_uXshxqs0', N'oqSy_#-SHSRCeEzRz+!XgcF#@NnV_UfmBXeqIx1WYEZqI56X7??mu1sGp8lPm8cj7jt1rEa', 2)
INSERT [dbo].[JwtAccounts] ([Token], [Identifier], [Id_TipoToken]) VALUES (N'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJVc2VyTmFtZSI6ImZyYW5jb21hbGZ1IiwibmJmIjoxNjk3OTU0MDc0LCJleHAiOjE2OTc5NTc2NzQsImlhdCI6MTY5Nzk1NDA3NH0.hmxyRIzGUd9aD93_Et50ooIpuIkzy9BZnB68R0osmEs', N'nRM_A03c5QwIVNOx0NWUPGbjq&yzhf1Ic8JxpG6fY_-?O#eMyuuO@0IKC9bcnOyJAfDF&IV', 2)
INSERT [dbo].[JwtAccounts] ([Token], [Identifier], [Id_TipoToken]) VALUES (N'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJVc2VyTmFtZSI6ImZyYW5jb21hbGZ1IiwibmJmIjoxNjk4MTIxNDM5LCJleHAiOjE2OTgxMjUwMzksImlhdCI6MTY5ODEyMTQzOX0.-apOy8jIAHDm2mXGFJdSJTO-sjS3NZUbhWOSBKeSgY4', N'sx@nT1Eo6W+7GlJg6-oPGo3RqzPW9CAHRcm?4RYj4huBN&Dj_Y_fiNZigXT2k&b7N-hvk7R', 2)
INSERT [dbo].[JwtAccounts] ([Token], [Identifier], [Id_TipoToken]) VALUES (N'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJVc2VyTmFtZSI6ImZyYW5jb21hbGZ1IiwibmJmIjoxNjk4MTIxNTMxLCJleHAiOjE2OTgxMjUxMzEsImlhdCI6MTY5ODEyMTUzMX0.GuNvJGnI_isMVyCI6JU3R7UGs_MXwUCJ7IBHw_gEDMQ', N'Wk_nsnSmS_WHZV74LYzQUIrFbw7ufI64tsDAPDxc+hmB&c1n5!_+sAz-cgvXRD8nQHy@PsU', 2)
INSERT [dbo].[JwtAccounts] ([Token], [Identifier], [Id_TipoToken]) VALUES (N'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJVc2VyTmFtZSI6ImZyYW5jb21hbGZ1IiwibmJmIjoxNjk4MTI0NTI3LCJleHAiOjE2OTgxMjgxMjcsImlhdCI6MTY5ODEyNDUyN30.n4cq1LEkkXhCPKgMFoOu3b6Rp-UZiGiph0OeHC36d5A', N'zdh1X+&wvtWsS*mJfHid2_DbUiopT&cu2+LKKXk!jHZkb0Zo0HcdU+m&b5O#&Z@MDUpl!3U', 2)
GO
SET IDENTITY_INSERT [dbo].[TipoTrabajador] ON 

INSERT [dbo].[TipoTrabajador] ([Id], [TipoTrabajador]) VALUES (1, N'Trabajador de tiempo completo')
INSERT [dbo].[TipoTrabajador] ([Id], [TipoTrabajador]) VALUES (2, N'Trabajador medio tiempo')
INSERT [dbo].[TipoTrabajador] ([Id], [TipoTrabajador]) VALUES (3, N'Trabajador por honorarios')
INSERT [dbo].[TipoTrabajador] ([Id], [TipoTrabajador]) VALUES (4, N'Practicante')
SET IDENTITY_INSERT [dbo].[TipoTrabajador] OFF
GO
SET IDENTITY_INSERT [dbo].[Trabajadores] ON 

INSERT [dbo].[Trabajadores] ([Id], [Nombre], [ApellidoPaterno], [ApellidoMaterno], [FechaCumpleanos], [FechaContratacion], [Telefono], [Email], [Municipio], [Estado], [TipoTrabajador]) VALUES (1, N'Ricardo', N'Pineda', N'Caracheo', CAST(N'1998-05-26T00:00:00.000' AS DateTime), CAST(N'2023-08-18T00:00:00.000' AS DateTime), N'442 156 78 98', N'ricardoPC@hotmail.com', N'Guanajuato', N'Guanajuato', 1)
INSERT [dbo].[Trabajadores] ([Id], [Nombre], [ApellidoPaterno], [ApellidoMaterno], [FechaCumpleanos], [FechaContratacion], [Telefono], [Email], [Municipio], [Estado], [TipoTrabajador]) VALUES (3, N'Arturo', N'Mejía', N'Hernández', CAST(N'1998-12-22T00:00:00.000' AS DateTime), CAST(N'2023-02-15T00:00:00.000' AS DateTime), N'441 110 98 78', N'amh98@hotmail.com', N'Jalpan', N'Santiago de Querétaro', 2)
SET IDENTITY_INSERT [dbo].[Trabajadores] OFF
GO
INSERT [dbo].[Trabajadores_Usuario] ([Id_Usuario], [Id_Trabajador], [AltaSistema]) VALUES (1, 1, CAST(N'2023-10-23T23:21:05.760' AS DateTime))
INSERT [dbo].[Trabajadores_Usuario] ([Id_Usuario], [Id_Trabajador], [AltaSistema]) VALUES (1, 3, CAST(N'2023-10-24T00:02:50.537' AS DateTime))
GO
SET IDENTITY_INSERT [dbo].[Usuarios] ON 

INSERT [dbo].[Usuarios] ([Id], [Usuario], [ApellidoMaterno], [ApellidoPaterno], [Correo], [Contraseña], [ConfirmacionCuenta], [FechaRegistro], [Nombre]) VALUES (1, N'francomalfu', N'Maldonado', N'Fuerte', N'francomalfu@gmail.com', N'$2a$11$BSLaKH9.EKunB.kcA0vSpuJSbpKmZW9oOvQ3uaLsVIFILmbM9K2Wa', 0, CAST(N'2023-10-23T23:15:28.147' AS DateTime), N'Franco')
SET IDENTITY_INSERT [dbo].[Usuarios] OFF
GO
ALTER TABLE [dbo].[JwtAccounts]  WITH CHECK ADD FOREIGN KEY([Id_TipoToken])
REFERENCES [dbo].[Jwt_Types] ([Id])
GO
ALTER TABLE [dbo].[Trabajadores]  WITH CHECK ADD FOREIGN KEY([TipoTrabajador])
REFERENCES [dbo].[TipoTrabajador] ([Id])
GO
/****** Object:  StoredProcedure [dbo].[STP_ACCOUNTSIGNUP]    Script Date: 24/10/2023 01:30:57 a. m. ******/
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
/****** Object:  StoredProcedure [dbo].[STP_ACTIVATEUSERACCOUNT]    Script Date: 24/10/2023 01:30:57 a. m. ******/
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
/****** Object:  StoredProcedure [dbo].[STP_ADDNEWORKER]    Script Date: 24/10/2023 01:30:57 a. m. ******/
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
/****** Object:  StoredProcedure [dbo].[STP_ADDNEWWORKER]    Script Date: 24/10/2023 01:30:57 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[STP_ADDNEWWORKER]
@idusuario integer,
@nombre nvarchar(350),
@apellidopat nvarchar(150),
@apellidomat nvarchar(150),
@cumpleanos datetime, 
@contratacion datetime,
@telefono nvarchar(20),
@email nvarchar(75),
@municipio nvarchar(100),
@estado nvarchar(100),
@tipotrabajador integer
AS
	BEGIN
		DECLARE  @error NVARCHAR(MAX);
		IF(SELECT COUNT(*) FROM Usuarios WHERE Id = @idusuario) = 1 
			BEGIN
				DECLARE @outputId table(IdUsuario int, IdTrabajador int, fecharegistro datetime)
				DECLARE	@id integer

				INSERT INTO Trabajadores (Nombre, ApellidoPaterno, ApellidoMaterno, FechaCumpleanos, FechaContratacion, 
					Telefono, Email, Municipio, Estado, TipoTrabajador)
				OUTPUT inserted.Id, @idusuario, GETDATE() INTO @outputId(IdTrabajador, IdUsuario, fecharegistro)
				VALUES (@nombre, @apellidopat, @apellidomat, @cumpleanos, @contratacion, @telefono, @email, @municipio, @estado, @tipotrabajador)

				INSERT INTO Trabajadores_Usuario (Id_Usuario, Id_Trabajador, AltaSistema)
				SELECT IdUsuario, IdTrabajador, fecharegistro FROM @outputId
			END
		ELSE 
			BEGIN
				SET @error = 'No exíste el usuario ingresado. Favor de verificar que tenga una cuenta creada.';
				RAISERROR(@error, 16, 1)
			END
		
	END
GO
/****** Object:  StoredProcedure [dbo].[STP_DELETEACCOUNT]    Script Date: 24/10/2023 01:30:57 a. m. ******/
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
/****** Object:  StoredProcedure [dbo].[STP_DELETEACCOUNTBYMAIL]    Script Date: 24/10/2023 01:30:57 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[STP_DELETEACCOUNTBYMAIL]
@mail nvarchar(150),
@identifierWB nvarchar(max)
AS
	BEGIN
		DELETE FROM Usuarios WHERE Correo = @mail
		DELETE FROM JwtAccounts WHERE Identifier = @identifierWB
	END
GO
/****** Object:  StoredProcedure [dbo].[STP_DELETEWORKER]    Script Date: 24/10/2023 01:30:57 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[STP_DELETEWORKER]
@idworker integer
AS
	BEGIN
		DECLARE  @error NVARCHAR(MAX);
		IF(SELECT COUNT(*) FROM Trabajadores WHERE Id = @idworker) = 1 
			BEGIN
				DELETE FROM Trabajadores WHERE Id = @idworker;
				DELETE FROM Trabajadores_Usuario WHERE Id_Trabajador = @idworker;
			END
		ELSE 
			BEGIN
				SET @error = 'No exíste un trabajador registrado.';
				RAISERROR(@error, 16, 1)
			END
		
	END
GO
/****** Object:  StoredProcedure [dbo].[STP_GETLOGININFO]    Script Date: 24/10/2023 01:30:57 a. m. ******/
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
/****** Object:  StoredProcedure [dbo].[STP_GETTOKENBYIDENTIFIER]    Script Date: 24/10/2023 01:30:57 a. m. ******/
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
/****** Object:  StoredProcedure [dbo].[STP_GETWORKERSBYIDUSER]    Script Date: 24/10/2023 01:30:57 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[STP_GETWORKERSBYIDUSER]
@idusuario integer
AS
	BEGIN
		DECLARE  @error NVARCHAR(MAX);
		IF(SELECT COUNT(*) FROM Usuarios WHERE Id = @idusuario) = 1 
			BEGIN
				SELECT CONCAT(tr.Nombre, ' ', tr.ApellidoPaterno, ' ', tr.ApellidoMaterno ) AS NombreCompleto, 
					tr.FechaCumpleanos, tr.FechaContratacion,
					tr.Telefono, tr.Email, tr.Municipio, tr.Estado, 
					tt.TipoTrabajador,
					tu.AltaSistema AS FechaRegistro
				FROM Trabajadores_Usuario AS tu
				INNER JOIN Trabajadores as tr ON tr.Id = tu.Id_Trabajador
				INNER JOIN TipoTrabajador as tt ON tt.Id = tr.TipoTrabajador
				WHERE tu.Id_Usuario = @idusuario
			END
		ELSE 
			BEGIN
				SET @error = 'No exíste el usuario ingresado. Favor de verificar que tenga una cuenta creada.';
				RAISERROR(@error, 16, 1)
			END
		
	END
GO
/****** Object:  StoredProcedure [dbo].[STP_INSERTTOKENDB]    Script Date: 24/10/2023 01:30:57 a. m. ******/
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
/****** Object:  StoredProcedure [dbo].[STP_UPDATEACCOUNTINFO]    Script Date: 24/10/2023 01:30:57 a. m. ******/
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
/****** Object:  StoredProcedure [dbo].[STP_UPDATEACCOUNTPASSWORD]    Script Date: 24/10/2023 01:30:57 a. m. ******/
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
/****** Object:  StoredProcedure [dbo].[STP_UPDATEWORKERBYID]    Script Date: 24/10/2023 01:30:57 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[STP_UPDATEWORKERBYID]
@idworker integer = null,
@nombre nvarchar(350) = null,
@apellidopat nvarchar(150) = null,
@apellidomat nvarchar(150) = null,
@cumpleanos datetime = null,
@contratacion datetime = null,
@telefono nvarchar(20) = null,
@email nvarchar(75) = null,
@municipio nvarchar(100) = null,
@estado nvarchar(100) = null,
@tipotrabajador integer = null
AS
	BEGIN
		DECLARE  @error NVARCHAR(MAX);
		IF(SELECT COUNT(*) FROM Trabajadores WHERE Id = @idworker) = 1 
			BEGIN
				UPDATE Trabajadores
				SET
					Nombre = CASE WHEN @nombre IS NOT NULL THEN @nombre ELSE Nombre END,
					ApellidoPaterno = CASE WHEN @apellidopat IS NOT NULL THEN @apellidopat ELSE ApellidoPaterno END,
					ApellidoMaterno = CASE WHEN @apellidomat IS NOT NULL THEN @apellidomat ELSE ApellidoMaterno END,
					FechaCumpleanos = CASE WHEN @cumpleanos IS NOT NULL THEN @cumpleanos ELSE FechaCumpleanos END,
					FechaContratacion = CASE WHEN @contratacion IS NOT NULL THEN @contratacion ELSE FechaContratacion END,
					Telefono = CASE WHEN @telefono IS NOT NULL THEN @telefono ELSE Telefono END,
					Email = CASE WHEN @email IS NOT NULL THEN @email ELSE Email END,
					Municipio = CASE WHEN @municipio IS NOT NULL THEN @municipio ELSE Municipio END,
					Estado = CASE WHEN @estado IS NOT NULL THEN @estado ELSE Estado END,
					TipoTrabajador = CASE WHEN @tipotrabajador IS NOT NULL THEN @tipotrabajador ELSE TipoTrabajador END
				WHERE Id = @idworker;		
			END
		ELSE 
			BEGIN
				SET @error = 'No exíste un trabajador registrado.';
				RAISERROR(@error, 16, 1)
			END
		
	END
GO
