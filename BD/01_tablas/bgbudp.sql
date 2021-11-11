CREATE TABLE bgbudp (
	cuid char (15)  NOT NULL ,
	cbudid char (10)  NOT NULL ,
	cbudno char (30)  NOT NULL ,
	cyear char (4)  NOT NULL ,
	cpdno char (2)  NOT NULL ,
	namt numeric(16, 2) NOT NULL ,
	namtused numeric(16, 2) NOT NULL ,
	nqty numeric(16, 4) NOT NULL ,
	nqtyused numeric(16, 4) NOT NULL ,
	tmodrec datetime NOT NULL ,
	namtaccr numeric(16, 2) NOT NULL ,
	nqtyaccr numeric(16, 4) NOT NULL ,
	namtmod numeric(16, 2) NOT NULL ,
	nqtymod numeric(16, 4) NOT NULL 
)

