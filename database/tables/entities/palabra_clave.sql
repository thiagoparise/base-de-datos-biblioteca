CREATE TABLE PalabraClave (
	idPalabraClave INT IDENTITY(1,1) NOT NULL,

	palabra NVARCHAR(100) NOT NULL,

	CONSTRAINT PK_PalabraClave PRIMARY KEY (idPalabraClave)
);