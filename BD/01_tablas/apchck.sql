if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[apchck]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[apchck]
GO

CREATE TABLE [dbo].[apchck] (
	[cvendno] [char] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[cpayto] [char] (40) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[cchktype] [char] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[cbankno] [char] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[cchkno] [char] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[ctogl] [char] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[dcheck] [datetime] NOT NULL ,
	[dcreate] [datetime] NOT NULL ,
	[lcancel] [smallint] NOT NULL ,
	[lhold] [smallint] NOT NULL ,
	[nchkamt] [numeric](16, 2) NOT NULL ,
	[nfchkamt] [numeric](16, 2) NOT NULL ,
	[nxchgrate] [numeric](16, 6) NOT NULL ,
	[nbchkamt] [numeric](16, 2) NOT NULL 
) ON [vam_user_data]
GO

