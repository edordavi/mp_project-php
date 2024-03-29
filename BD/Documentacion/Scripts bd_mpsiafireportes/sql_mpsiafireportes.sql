USE [mpsiafireportes]
GO
/****** Object:  StoredProcedure [dbo].[sp_reporte_presupuesto_programa]    Script Date: 08/22/2014 09:34:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Emil Ordoñez>
-- Create date: <2014-08-19>
-- Description:	<Reporte Presupuestario por Programa>
-- =============================================
CREATE PROCEDURE [dbo].[sp_reporte_presupuesto_programa]

AS
BEGIN
	
	SET NOCOUNT ON;

	SELECT SUBSTRING(budget.cbudno,5,3) AS PROGRAMA ,budget.cbudid AS PRESUPUESTO,
			(SUM(budget.namtmod) - SUM(budget.namt)) AS TRANSFERENCIA,
			SUM(budget.namtmod) AS MODIFICADO, SUM(budget.namtused) AS UTILIZADO,
			SUM(budget.namtmod - budget.namtused) AS DISPONIBLE,
			(SUM(budget.namtused) / SUM(budget.namtmod)) AS '% UTILIZADO',
			((SUM(budget.namtmod) - SUM(budget.namtused)) / SUM(budget.namtmod)) AS '% DISPONIBLE'
		FROM mpsiafi.dbo.bgbudt AS budget
		WHERE SUBSTRING(budget.cbudid,5,4) = YEAR(GETDATE())
		GROUP BY SUBSTRING(budget.cbudno,5,3), budget.cbudid
END
GO
/****** Object:  StoredProcedure [dbo].[sp_reporte_presupuesto_grupo]    Script Date: 08/22/2014 09:34:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Emil Ordoñez>
-- Create date: <2014-08-19>
-- Description:	<Reporte Presupuestario por Programa>
-- =============================================
CREATE PROCEDURE [dbo].[sp_reporte_presupuesto_grupo]

AS
BEGIN
	
	SET NOCOUNT ON;

	SELECT SUBSTRING(budget.cbudno,17,1) AS GRUPO ,budget.cbudid AS PRESUPUESTO,
			(SUM(budget.namtmod) - SUM(budget.namt)) AS TRANSFERENCIA,
			SUM(budget.namtmod) AS MODIFICADO, SUM(budget.namtused) AS UTILIZADO,
			SUM(budget.namtmod - budget.namtused) AS DISPONIBLE,
			(SUM(budget.namtused) / SUM(budget.namtmod)) AS '% UTILIZADO',
			((SUM(budget.namtmod) - SUM(budget.namtused)) / SUM(budget.namtmod)) AS '% DISPONIBLE'
		FROM mpsiafi.dbo.bgbudt AS budget
		WHERE SUBSTRING(budget.cbudid,5,4) = YEAR(GETDATE())
		GROUP BY SUBSTRING(budget.cbudno,17,1), budget.cbudid
END
GO
/****** Object:  StoredProcedure [dbo].[sp_reporte_presupuesto_subgrupo]    Script Date: 08/22/2014 09:34:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  PROCEDURE [dbo].[sp_reporte_presupuesto_subgrupo]
AS
BEGIN
SELECT SUBSTRING(budget.cbudno,17,2) AS "SUB GRUPO", 
	  (budget.cbudid) AS "PRESUPUESTO", 
	  (SUM(budget.namtmod) - SUM(budget.namt)) AS "TRANSFERENCIA", 
	   SUM(budget.namtmod) AS "MODIFICADO",
	   SUM(budget.namtused) AS "UTILIZADO", 
	  (SUM(budget.namtmod) - SUM(budget.namtused)) AS "DISPONIBLE",
	  (SUM(budget.namtused) / SUM(budget.namtmod)) AS "% UTILIZADO", 
	  ((SUM(budget.namtmod) - SUM(budget.namtused)) / SUM(budget.namtmod)) AS "% DISPONIBLE"
FROM mpsiafi.dbo.bgbudt as budget 
WHERE SUBSTRING(budget.cbudid,5,4) = YEAR(GETDATE())
GROUP BY SUBSTRING(budget.cbudno,17,2), budget.cbudid;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_reporte_deducciones_empleados]    Script Date: 08/22/2014 09:34:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Emil Ordoñez>
-- Create date: <2014-08-19>
-- Description:	<Reporte Presupuestario por Programa>
-- =============================================
CREATE PROCEDURE [dbo].[sp_reporte_deducciones_empleados]

AS
BEGIN
	
	SET NOCOUNT ON;
	
	SELECT empl.cempno AS '# EMPLEADO',empl.cfedid AS 'IDENTIDAD',
		empl.cfname AS NOMBRES, empl.clname AS APELLIDOS,
		jobs.cDesc AS CARGO, empl.cdeptno AS 'COD. DEPTO.',
		dept.cdeptname AS 'DEPTO.', misd.cpayno AS PLANILLA,
		misd.cdedno AS 'COD. DED.', misd.cdesc AS DESCRIPCION,
		misd.ndedamt AS 'VALOR DED.'
		FROM mpsiafi.dbo.prempy AS empl
			INNER JOIN mpsiafi.dbo.HRJobs AS jobs
				ON empl.cjobtitle = jobs.cJobTitlNO
			INNER JOIN mpsiafi.dbo.prdept AS dept
				ON empl.cdeptno = dept.cdeptno
			INNER JOIN mpsiafi.dbo.prmisd AS misd
				ON empl.cempno = misd.cempno
	
END
GO
/****** Object:  StoredProcedure [dbo].[sp_reporte_ingreso_empleados]    Script Date: 08/22/2014 09:34:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_reporte_ingreso_empleados]
AS
BEGIN
SET NOCOUNT ON;
	SELECT E.cempno AS "CODIGO", E.cfedid AS "IDENTIDAD", E.cfname AS "NOMBRES", E.clname AS "APELLIDOS", J.cDesc AS "CARGO", E.cdeptno AS "COD. DEPTO.", 
	D.cdeptname AS "DEPTO.", M.cref AS "REFERENCIA", M.cbankno AS "BANCO", M.cchkno AS "CHEQUE", M.cpayno AS "PLANILLA", M.cpaycode AS "COD. INGR.", 
	(M.nqty*M.nrate) AS "VALOR INGR." 
	FROM mpsiafi.dbo.prempy AS E, mpsiafi.dbo.prmisc AS M, mpsiafi.dbo.prdept AS D, mpsiafi.dbo.HrJobs AS J 
	WHERE E.cdeptno = D.cdeptno  AND E.cjobtitle = J.cJobTitlNO AND E.cempno = M.cempno 
END
GO
/****** Object:  StoredProcedure [dbo].[sp_reporte_presupuesto_compara]    Script Date: 08/22/2014 09:34:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Emil Ordoñez>
-- Create date: <2014-08-19>
-- Description:	<Reporte Presupuestario por Programa>
-- =============================================
CREATE PROCEDURE [dbo].[sp_reporte_presupuesto_compara]

AS
BEGIN
	
	SET NOCOUNT ON;

	SELECT budget.cbudno AS CUENTA ,budget.cbudid AS PRESUPUESTO,
			(budget.namt) AS ORIGINAL,
			(budget.namtmod) AS MODIFICADO, (budget.namtused) AS UTILIZADO,
			(budget.namtmod - budget.namtused) AS DISPONIBLE,
			((budget.namtused) / (budget.namtmod)) AS '% UTILIZADO',
			(((budget.namtmod) - (budget.namtused)) / (budget.namtmod)) AS '% DISPONIBLE'
		FROM mpsiafi.dbo.bgbudt AS budget
		WHERE SUBSTRING(budget.cbudid,5,4) = YEAR(GETDATE())
END
GO
/****** Object:  StoredProcedure [dbo].[sp_reporte_presupuesto_transacciones]    Script Date: 08/22/2014 09:34:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[sp_reporte_presupuesto_transacciones]

AS
BEGIN
	
	SET NOCOUNT ON;

	((SELECT 'TRANS.' AS TIPO,CONVERT(VARCHAR,trn.cfbudno) AS DESDE,
		trn.ctbudno AS HASTA, trn.ntrfamt AS 'CANT.',
		trn.tmodrec AS FECHA
		FROM mpsiafi.dbo.bgtrfm AS trn
		WHERE YEAR(trn.tmodrec) = YEAR(GETDATE())
	)
	UNION
	(SELECT 'AJUST.' AS TIPO,'N/A' AS DESDE,
		aju.cbudno AS HASTA, aju.nadjamt AS 'CANT.',
		aju.tmodrec AS FECHA
		FROM mpsiafi.dbo.bgadjm AS aju
		WHERE YEAR(aju.tmodrec) = YEAR(GETDATE())
	))ORDER BY FECHA
END
GO
/****** Object:  Table [dbo].[tbl_usuarios]    Script Date: 08/22/2014 09:34:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_usuarios](
	[id_usuario] [varchar](45) NOT NULL,
	[prnombre] [varchar](50) NOT NULL,
	[sgnombre] [varchar](50) NULL,
	[prapellido] [varchar](50) NOT NULL,
	[sgapellido] [varchar](50) NULL,
	[clave] [varbinary](50) NOT NULL,
	[fecha_creacion] [datetime] NULL,
	[fecha_ultimo_ingreso] [datetime] NULL,
	[email] [varchar](100) NOT NULL,
 CONSTRAINT [tbl_usuarios_PK] PRIMARY KEY CLUSTERED 
(
	[id_usuario] ASC
) ON [PRIMARY],
 CONSTRAINT [UQ_tbl_usuarios] UNIQUE NONCLUSTERED 
(
	[id_usuario] ASC
) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[tbl_usuarios] ([id_usuario], [prnombre], [sgnombre], [prapellido], [sgapellido], [clave], [fecha_creacion], [fecha_ultimo_ingreso], [email]) VALUES (CONVERT(TEXT, N'1'), CONVERT(TEXT, N'Osly'), CONVERT(TEXT, N'Jonathan'), CONVERT(TEXT, N'Salinas'), CONVERT(TEXT, N'Padilla'), 0x0100624B606CACE9649F567EB921C42D2099467205535A1381D05C71163809C744E738E9334134D401B06FF8EFEC, CAST(0x0000A2AD00000000 AS DateTime), CAST(0x0000A38F004E664B AS DateTime), CONVERT(TEXT, N'ojsalinas@ministerio.com'))
INSERT [dbo].[tbl_usuarios] ([id_usuario], [prnombre], [sgnombre], [prapellido], [sgapellido], [clave], [fecha_creacion], [fecha_ultimo_ingreso], [email]) VALUES (CONVERT(TEXT, N'3'), CONVERT(TEXT, N'Juan'), CONVERT(TEXT, N'Mekelele'), CONVERT(TEXT, N'Ramirez'), CONVERT(TEXT, N'Ruiz'), 0x01005F765F1317BB4C7DBC3428CB871C51591F9EC07F37CD1BD01D9D0F4B21267EB03945BC8B810686D11C980A91, CAST(0x0000A2AD00000000 AS DateTime), CAST(0x0000A3BE00000000 AS DateTime), CONVERT(TEXT, N'juan@ministerio.com'))
INSERT [dbo].[tbl_usuarios] ([id_usuario], [prnombre], [sgnombre], [prapellido], [sgapellido], [clave], [fecha_creacion], [fecha_ultimo_ingreso], [email]) VALUES (CONVERT(TEXT, N'eavila'), CONVERT(TEXT, N'Emil'), NULL, CONVERT(TEXT, N'OrdoÃ±ez'), NULL, 0x0100FB5869412F8246B7B4720D24ED11CDD1B79806C66FC2EA8226359409A2C0C64A7C09A36A008CE9781FAAF1F7, CAST(0x0000A38F004E9669 AS DateTime), CAST(0x0000A38F009D598E AS DateTime), CONVERT(TEXT, N'eavila@mp.com'))
INSERT [dbo].[tbl_usuarios] ([id_usuario], [prnombre], [sgnombre], [prapellido], [sgapellido], [clave], [fecha_creacion], [fecha_ultimo_ingreso], [email]) VALUES (CONVERT(TEXT, N'epson'), CONVERT(TEXT, N'Edson'), NULL, CONVERT(TEXT, N'Bonilla'), NULL, 0x010020568E0412F1B4250C4AD48F48AD36BE48BF9CC09719B1A3EBD800DC2D792589090E45A4F4F7A6061471857B, CAST(0x0000A38F004CDB0A AS DateTime), CAST(0x0000A38F004DA394 AS DateTime), CONVERT(TEXT, N'ed@m.c'))
INSERT [dbo].[tbl_usuarios] ([id_usuario], [prnombre], [sgnombre], [prapellido], [sgapellido], [clave], [fecha_creacion], [fecha_ultimo_ingreso], [email]) VALUES (CONVERT(TEXT, N'Sindeee'), CONVERT(TEXT, N'Sindy'), NULL, CONVERT(TEXT, N'Garcia'), NULL, 0x0100FA4AD32CC9C729D44765C850CFCBE317C07A8185DA68C46182E85BAE9D8EB19EED6F8382FBA9A6A264B758A3, CAST(0x0000A38F00498FA8 AS DateTime), NULL, CONVERT(TEXT, N'sgarcia@ministerio.com'))
/****** Object:  Table [dbo].[tbl_rol]    Script Date: 08/22/2014 09:34:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_rol](
	[id_rol] [smallint] NOT NULL,
	[descripcion] [varchar](45) NULL,
 CONSTRAINT [tbl_rol_PK] PRIMARY KEY CLUSTERED 
(
	[id_rol] ASC
) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[tbl_rol] ([id_rol], [descripcion]) VALUES (1, CONVERT(TEXT, N'Admin'))
INSERT [dbo].[tbl_rol] ([id_rol], [descripcion]) VALUES (2, CONVERT(TEXT, N'TI'))
INSERT [dbo].[tbl_rol] ([id_rol], [descripcion]) VALUES (3, CONVERT(TEXT, N'Gerencia'))
/****** Object:  StoredProcedure [dbo].[sp_reporte_empl_cuentas_presupuestarias]    Script Date: 08/22/2014 09:34:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_reporte_empl_cuentas_presupuestarias]
	@cargo VARCHAR(40)='', @depto VARCHAR(30)='',@codpres VARCHAR(30)='',
	@est VARCHAR(2)='',@fcontrIn DATETIME=NULL,@fcontrFn DATETIME=NULL,
	@facrdIn DATETIME=NULL,@facrdFn DATETIME=NULL
	AS
BEGIN 
	SET NOCOUNT ON;
	IF @facrdIn='' BEGIN
		SET @facrdIn = '19000101'
	END
	IF @facrdFn='' BEGIN
		SET @facrdFn = '29000101'
	END
	IF @fcontrIn='' BEGIN
		SET @fcontrIn = '19000101'
	END
	IF @fcontrFn='' BEGIN
		SET @fcontrFn = '29000101'
	END

	SELECT empy.cempno AS CODIGO, empy.cfedid AS ID, 
			empy.cfname AS NOMBRES,
			empy.clname AS APELLIDOS, empy.csex AS SEXO,
			empy.dbirth AS NACIMIENTO, empy.cdeptno AS 'COD. DEPTO', 
			dept.cdeptname AS 'DEPTO. NOMBRE', jobs.cDesc AS CARGO, 
			empy.nmonthpay AS SALARIO, empy.dcntrct AS 'F. CONTRATO',
			empy.dhire AS 'F. ACUERDO',
			empy.ctaxstate, empy.cpaytype AS 'T. PLANILLA',
			empy.cstate AS ESTADO, empg.cwageacc AS 'COD. PRES'
		FROM mpsiafi.dbo.prempy AS empy, mpsiafi.dbo.HRJobs AS jobs,
			mpsiafi.dbo.prdept AS dept, mpsiafi.dbo.prempg AS empg
		WHERE empy.cdeptno = dept.cdeptno
			AND empy.cjobtitle = jobs.cJobTitlNO 
			AND empy.cempno = empg.cempno
			AND dhire BETWEEN ISNULL(@facrdIn,'19000101') 
						AND ISNULL(@facrdFn, '29001231')
			AND dcntrct BETWEEN ISNULL(@fcontrIn,'19000101') 
						AND ISNULL(@fcontrFn, '29001231')
			AND jobs.cDesc LIKE '%'+ ISNULL(@cargo,'') +'%' 
			AND dept.cdeptname LIKE '%'+ ISNULL(@depto,'') +'%'
			AND empg.cwageacc LIKE '%'+ ISNULL(@codpres,'') +'%' 
			AND empy.cstate LIKE '%'+ ISNULL(@est,'') +'%'		
END
GO
/****** Object:  Table [dbo].[tbl_rol_usuario]    Script Date: 08/22/2014 09:34:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_rol_usuario](
	[id_usuario] [varchar](45) NOT NULL,
	[id_rol] [smallint] NOT NULL,
 CONSTRAINT [tbl_rol_usuario_PK] PRIMARY KEY CLUSTERED 
(
	[id_usuario] ASC,
	[id_rol] ASC
) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[tbl_rol_usuario] ([id_usuario], [id_rol]) VALUES (CONVERT(TEXT, N'1'), 1)
INSERT [dbo].[tbl_rol_usuario] ([id_usuario], [id_rol]) VALUES (CONVERT(TEXT, N'3'), 3)
INSERT [dbo].[tbl_rol_usuario] ([id_usuario], [id_rol]) VALUES (CONVERT(TEXT, N'eavila'), 1)
INSERT [dbo].[tbl_rol_usuario] ([id_usuario], [id_rol]) VALUES (CONVERT(TEXT, N'epson'), 3)
INSERT [dbo].[tbl_rol_usuario] ([id_usuario], [id_rol]) VALUES (CONVERT(TEXT, N'Sindeee'), 3)
/****** Object:  StoredProcedure [dbo].[sp_login]    Script Date: 08/22/2014 09:34:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_login]
	@correo VARCHAR(100),@clave VARCHAR(50)
AS
BEGIN
	
	SET NOCOUNT ON;

	SELECT TOP 1 (usr.prnombre + ' ' + usr.prapellido + ' - ' + rol.descripcion) AS NOMBRE, rol.id_rol AS ROL 
		FROM mpsiafireportes.dbo.tbl_usuarios AS usr
			INNER JOIN mpsiafireportes.dbo.tbl_rol_usuario AS rolusr
				ON usr.id_usuario = rolusr.id_usuario
			INNER JOIN mpsiafireportes.dbo.tbl_rol AS rol
				ON rol.id_rol = rolusr.id_rol
		WHERE usr.email = @correo AND PWDCOMPARE(@clave,usr.clave)=1
		
	
	UPDATE mpsiafireportes.dbo.tbl_usuarios
		SET fecha_ultimo_ingreso = GETDATE()
		WHERE email = @correo
END
GO
/****** Object:  StoredProcedure [dbo].[sp_getroles]    Script Date: 08/22/2014 09:34:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_getroles]
	
AS
BEGIN
	SET NOCOUNT ON;

    SELECT r.id_rol AS ROL,r.descripcion AS 'DESC'
		FROM tbl_rol AS r
END
GO
/****** Object:  StoredProcedure [dbo].[sp_eliminausuario]    Script Date: 08/22/2014 09:34:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_eliminausuario]
	@correo VARCHAR(100)
AS
BEGIN
	
	SET NOCOUNT ON;
	DELETE FROM tbl_rol_usuario
		WHERE id_usuario IN (SELECT id_usuario FROM tbl_usuarios WHERE email=@correo)

	DELETE FROM tbl_usuarios
		WHERE email = @correo
	
	RETURN @@ERROR;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_nuevousuario]    Script Date: 08/22/2014 09:34:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_nuevousuario]
	@idusuario VARCHAR(45),@correo VARCHAR(100),
	@prnombre VARCHAR(50),
	@prapellido VARCHAR(50),
	@clave VARCHAR(50)=NULL,@rol TINYINT=3
AS
BEGIN
	
    -- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	--DECLARE @error INT;
	
    --BEGIN TRANSACTION
		INSERT INTO tbl_usuarios (id_usuario,email,prnombre,
				prapellido,clave,fecha_creacion)
			VALUES(@idusuario,@correo,@prnombre,
				@prapellido,
				PWDENCRYPT(ISNULL(@clave,'123456')),GETDATE())
		
		INSERT INTO tbl_rol_usuario (id_usuario,id_rol)
			VALUES (@idusuario,@rol)			
		
	--SET @error = @@ERROR;	
	--IF @error <> 0 BEGIN
	--	COMMIT
	--	RETURN 0;
	--END
	--ELSE BEGIN
	--	ROLLBACK
	--	RETURN @error;
	--END
	
END
GO
/****** Object:  StoredProcedure [dbo].[sp_reiniciaclave]    Script Date: 08/22/2014 09:34:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_reiniciaclave]
	@correo VARCHAR(100),@clave VARCHAR(50)='123456'
AS
BEGIN
	
	SET NOCOUNT ON;

	UPDATE tbl_usuarios
		SET clave = PWDENCRYPT(@clave)
		WHERE email=@correo;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_getusuarios]    Script Date: 08/22/2014 09:34:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_getusuarios]
	@id VARCHAR(45)='',@correo VARCHAR(100)=''
AS
BEGIN
	SET NOCOUNT ON;
	SELECT u.email AS CORREO,u.id_usuario AS ID
		FROM tbl_usuarios AS u
		WHERE u.email LIKE '%' + @correo + '%'
			AND u.id_usuario LIKE '%' + @id + '%'
END
GO
/****** Object:  ForeignKey [tbl_rol_usuario_tbl_rol_FK]    Script Date: 08/22/2014 09:34:57 ******/
ALTER TABLE [dbo].[tbl_rol_usuario]  WITH CHECK ADD  CONSTRAINT [tbl_rol_usuario_tbl_rol_FK] FOREIGN KEY([id_rol])
REFERENCES [dbo].[tbl_rol] ([id_rol])
GO
ALTER TABLE [dbo].[tbl_rol_usuario] CHECK CONSTRAINT [tbl_rol_usuario_tbl_rol_FK]
GO
/****** Object:  ForeignKey [tbl_rol_usuario_tbl_usuarios_FK]    Script Date: 08/22/2014 09:34:57 ******/
ALTER TABLE [dbo].[tbl_rol_usuario]  WITH NOCHECK ADD  CONSTRAINT [tbl_rol_usuario_tbl_usuarios_FK] FOREIGN KEY([id_usuario])
REFERENCES [dbo].[tbl_usuarios] ([id_usuario])
GO
ALTER TABLE [dbo].[tbl_rol_usuario] CHECK CONSTRAINT [tbl_rol_usuario_tbl_usuarios_FK]
GO
