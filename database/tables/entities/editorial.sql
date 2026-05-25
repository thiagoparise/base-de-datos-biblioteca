CREATE TABLE Editorial (
	idEditorial INT IDENTITY(1,1) NOT NULL,

	nombre NVARCHAR(100) NOT NULL,

	CONSTRAINT PK_Editorial PRIMARY KEY (idEditorial)
);