/*    ==Scripting Parameters==

    Source Server Version : SQL Server 2008 (10.0.6241)
    Source Database Engine Edition : Microsoft SQL Server Express Edition
    Source Database Engine Type : Standalone SQL Server

    Target Server Version : SQL Server 2017
    Target Database Engine Edition : Microsoft SQL Server Standard Edition
    Target Database Engine Type : Standalone SQL Server
*/

USE [JoyanaSecurityDB]
GO
/****** Object:  User [IIS APPPOOL\.NET v4.5 Classic]    Script Date: 17/04/2018 16:03:57 ******/
CREATE USER [IIS APPPOOL\.NET v4.5 Classic] FOR LOGIN [IIS APPPOOL\.NET v4.5 Classic]
GO
ALTER ROLE [db_owner] ADD MEMBER [IIS APPPOOL\.NET v4.5 Classic]
GO
/****** Object:  Table [dbo].[tblAlarma]    Script Date: 17/04/2018 16:03:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblAlarma](
	[idAlarma] [int] IDENTITY(1,1) NOT NULL,
	[contraseña] [nvarchar](100) NOT NULL,
	[latitud] [nvarchar](20) NOT NULL,
	[longitud] [nvarchar](20) NOT NULL,
	[isActive] [bit] NOT NULL,
	[idUsuario] [int] NULL,
 CONSTRAINT [PK_tblAlarma] PRIMARY KEY CLUSTERED 
(
	[idAlarma] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblReporte]    Script Date: 17/04/2018 16:03:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblReporte](
	[idReporte] [int] IDENTITY(1,1) NOT NULL,
	[fechaActivacion] [nvarchar](100) NOT NULL,
	[idAlarma] [int] NOT NULL,
 CONSTRAINT [PK_tblReporte] PRIMARY KEY CLUSTERED 
(
	[idReporte] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblUsuario]    Script Date: 17/04/2018 16:03:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblUsuario](
	[idUsuario] [int] IDENTITY(1,1) NOT NULL,
	[nombreCompleto] [nvarchar](100) NOT NULL,
	[email] [nvarchar](100) NOT NULL,
	[password] [nvarchar](100) NOT NULL,
	[telefono] [nvarchar](20) NOT NULL,
	[direccion] [nvarchar](500) NULL,
 CONSTRAINT [PK_tblUsuario] PRIMARY KEY CLUSTERED 
(
	[idUsuario] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[tblAlarma]  WITH CHECK ADD  CONSTRAINT [FK_tblAlarma_tblUsuario] FOREIGN KEY([idUsuario])
REFERENCES [dbo].[tblUsuario] ([idUsuario])
GO
ALTER TABLE [dbo].[tblAlarma] CHECK CONSTRAINT [FK_tblAlarma_tblUsuario]
GO
ALTER TABLE [dbo].[tblReporte]  WITH CHECK ADD  CONSTRAINT [FK_tblReporte_tblAlarma] FOREIGN KEY([idAlarma])
REFERENCES [dbo].[tblAlarma] ([idAlarma])
GO
ALTER TABLE [dbo].[tblReporte] CHECK CONSTRAINT [FK_tblReporte_tblAlarma]
GO
/****** Object:  StoredProcedure [dbo].[ALA_GetAlarmaById]    Script Date: 17/04/2018 16:03:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		José Manuel Cadima Aponte
-- Create date: 20/03/2018
-- Description:	Obtener Alarma por idAlarma
-- =============================================
CREATE PROCEDURE [dbo].[ALA_GetAlarmaById]
	-- Add the parameters for the stored procedure here
	@idAlarma	INT

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT * FROM tblAlarma WHERE [idAlarma] = @idAlarma
END
GO
/****** Object:  StoredProcedure [dbo].[ALA_GetAlarmaByUsuarioId]    Script Date: 17/04/2018 16:03:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		José Manuel Cadima Aponte
-- Create date: 27/03/2018
-- Description:	Obtiene la alarma por el idUsuario
-- =============================================
CREATE PROCEDURE [dbo].[ALA_GetAlarmaByUsuarioId]
	-- Add the parameters for the stored procedure here
	@idUsuario		INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT * FROM [dbo].[tblAlarma] WHERE [idUsuario] = @idUsuario
END
GO
/****** Object:  StoredProcedure [dbo].[ALA_GetAllAlarma]    Script Date: 17/04/2018 16:03:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		José Manuel Cadima Aponte
-- Create date: 20/03/2018
-- Description:	Obtener todo el listaado de alarmas
-- =============================================
CREATE PROCEDURE [dbo].[ALA_GetAllAlarma]
	-- Add the parameters for the stored procedure here
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT * FROM tblAlarma
END
GO
/****** Object:  StoredProcedure [dbo].[ALA_InsertarAlarma]    Script Date: 17/04/2018 16:03:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		José Manuel Cadima Aponte
-- Create date: 20/03/2018
-- Description:	Insertar Alarma
-- =============================================
CREATE PROCEDURE [dbo].[ALA_InsertarAlarma]
	-- Add the parameters for the stored procedure here
	@contraseña		NVARCHAR(100),
	@latitud		NVARCHAR(20),
	@longitud		NVARCHAR(20),
	@isActive		BIT,
	@idUsuario		INT,
	
	@idAlarma		INT OUTPUT 

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	INSERT INTO [dbo].[tblAlarma]           
           ([contraseña]
           ,[latitud]
           ,[longitud]
		   ,[isActive]
           ,[idUsuario])
     VALUES           
           (@contraseña
           ,@latitud
           ,@longitud
		   ,@isActive
           ,@idUsuario)

	SET @idAlarma = SCOPE_IDENTITY();
END
GO
/****** Object:  StoredProcedure [dbo].[ALA_UpdateAlarma]    Script Date: 17/04/2018 16:03:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		José Manuel Cadima Aponte
-- Create date: 20/03/2018
-- Description:	Actualizar Alarma
-- =============================================
CREATE PROCEDURE [dbo].[ALA_UpdateAlarma]
	-- Add the parameters for the stored procedure here	
	@contraseña		NVARCHAR(100),
	@latitud		NVARCHAR(20),
	@longitud		NVARCHAR(20),
	@isActive		BIT,

	@idAlarma		INT
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	UPDATE [dbo].[tblAlarma]
	SET [contraseña] = @contraseña
      ,[latitud] = @latitud
      ,[longitud] = @longitud      
	  ,[isActive] = @isActive
	WHERE [idAlarma] = @idAlarma 

    -- Insert statements for procedure here
	
END
GO
/****** Object:  StoredProcedure [dbo].[CLI_DeleteUsuario]    Script Date: 17/04/2018 16:03:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[CLI_DeleteUsuario]
	-- Add the parameters for the stored procedure here
	@idUsuario	INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	DELETE FROM [dbo].[tblUsuario] WHERE [idUsuario] = @idUsuario
END
GO
/****** Object:  StoredProcedure [dbo].[CLI_GetAllUsers]    Script Date: 17/04/2018 16:03:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		José Manuel Cadima Aponte
-- Create date: 20/02/2018
-- Description:	Obtener todos los usuarios
-- =============================================
CREATE PROCEDURE [dbo].[CLI_GetAllUsers]
	-- Add the parameters for the stored procedure here	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT * FROM tblUsuario 	
END
GO
/****** Object:  StoredProcedure [dbo].[CLI_GetUserByEmail]    Script Date: 17/04/2018 16:03:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		José Manuel Cadima Aponte
-- Create date: 20/02/2018
-- Description:	Obtener usuario por Email
-- =============================================
CREATE PROCEDURE [dbo].[CLI_GetUserByEmail]
	-- Add the parameters for the stored procedure here
	@email		NVARCHAR(100)

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT * FROM tblUsuario 
	WHERE [email] = @email

END
GO
/****** Object:  StoredProcedure [dbo].[CLI_GetUserById]    Script Date: 17/04/2018 16:03:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		José Manuel Cadima Aponte
-- Create date: 20/02/2018
-- Description:	Obtener usuario por idUsuario
-- =============================================
CREATE PROCEDURE [dbo].[CLI_GetUserById]
	-- Add the parameters for the stored procedure here
	@idUsuario		INT

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT * FROM tblUsuario 
	WHERE [idUsuario] = @idUsuario

END
GO
/****** Object:  StoredProcedure [dbo].[CLI_InsertarUsuario]    Script Date: 17/04/2018 16:03:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		José Manuel Cadima Aponte
-- Create date: 20/03/2018
-- Description:	Insertar Usuario
-- =============================================
CREATE PROCEDURE [dbo].[CLI_InsertarUsuario]
	-- Add the parameters for the stored procedure here
	@nombreUsuario	NVARCHAR(100),
	@email			NVARCHAR(100),
	@password		NVARCHAR(100),	
	@telefono		NVARCHAR(20),
	@direccion		NVARCHAR(500),

	@idUsuario		INT OUTPUT


AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	INSERT INTO [dbo].[tblUsuario]
           ([nombreCompleto]
           ,[email]
           ,[password]
           ,[telefono]
           ,[direccion])
     VALUES
           (@nombreUsuario
           ,@email
           ,@password
           ,@telefono
           ,@direccion)

	SET @idUsuario = SCOPE_IDENTITY()

END
GO
/****** Object:  StoredProcedure [dbo].[CLI_UpdateUsuario]    Script Date: 17/04/2018 16:03:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		José Manuel Cadima Aponte
-- Create date: 20/02/2018
-- Description:	Actualizar usuario
-- =============================================
CREATE PROCEDURE [dbo].[CLI_UpdateUsuario]
	-- Add the parameters for the stored procedure here
	@nombreCompleto	NVARCHAR(100),
	@email			NVARCHAR(100),
	@password		NVARCHAR(100),
	@telefono		NVARCHAR(20),
	@direccion		NVARCHAR(500),

	@idUsuario		INT

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	UPDATE [dbo].[tblUsuario]
	SET [nombreCompleto] = @nombreCompleto
      ,[email] = @email
      ,[password] = @password
      ,[telefono] = @telefono
      ,[direccion] = @direccion
	WHERE [idUsuario] = @idUsuario

END
GO
/****** Object:  StoredProcedure [dbo].[REP_GetAllReports]    Script Date: 17/04/2018 16:03:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		José Manuel Cadima Aponte
-- Create date: 24/03/2018
-- Description:	Obtener todos lo reportes
-- =============================================
CREATE PROCEDURE [dbo].[REP_GetAllReports]
	-- Add the parameters for the stored procedure here	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT * FROM [dbo].[tblReporte]
END
GO
/****** Object:  StoredProcedure [dbo].[REP_GetLastReportByAlarma]    Script Date: 17/04/2018 16:03:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		José Manuel Cadima Aponte
-- Create date: 20/03/2018
-- Description:	Obtener los 10 ultimas veces que se activo la alarma
-- =============================================
CREATE PROCEDURE [dbo].[REP_GetLastReportByAlarma]
	-- Add the parameters for the stored procedure here
	@idAlarma		INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT TOP(10) * FROM tblReporte 
	WHERE [idAlarma] = @idAlarma 
	ORDER BY idAlarma DESC 
END
GO
/****** Object:  StoredProcedure [dbo].[REP_InsertarReporte]    Script Date: 17/04/2018 16:03:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		José Manuel Cadima Aponte
-- Create date: 20/03/2018
-- Description:	Insertar Reporte
-- =============================================
CREATE PROCEDURE [dbo].[REP_InsertarReporte]
	-- Add the parameters for the stored procedure here
	@fechaActivacion	NVARCHAR(100),
	@idAlarma			INT,

	@idReporte			INT OUTPUT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	INSERT INTO [dbo].[tblReporte]
           ([fechaActivacion]
           ,[idAlarma])
     VALUES
           (@fechaActivacion
           ,@idReporte)

	SET @idReporte = SCOPE_IDENTITY()

END
GO
