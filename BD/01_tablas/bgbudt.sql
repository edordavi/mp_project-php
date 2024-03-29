

CREATE TABLE dbo.bgbudt (
	cuid char (15)  NOT NULL ,
	cbudid char (10)  NOT NULL ,
	cbudno char (30)  NOT NULL ,
	cdesc char (54)  NOT NULL ,
	cstmacct char (30)  NOT NULL ,
	crsvacct char (30)  NOT NULL ,
	cclsid char (10)  NOT NULL ,
	ctypid char (10)  NOT NULL ,
	cdeptno char (10)  NOT NULL ,
	namt numeric(16, 2) NOT NULL ,
	namtused numeric(16, 2) NOT NULL ,
	nqty numeric(16, 4) NOT NULL ,
	nqtyused numeric(16, 4) NOT NULL ,
	tmodrec datetime NOT NULL ,
	namtaccr numeric(16, 2) NOT NULL ,
	nqtyaccr numeric(16, 4) NOT NULL ,
	namtmod numeric(16, 2) NOT NULL ,
	nqtymod numeric(16, 4) NOT NULL 
) ON vam_user_data
GO

