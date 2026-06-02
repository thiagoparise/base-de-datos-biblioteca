CREATE TABLE PalabraClave (
	id_palabra_clave INT IDENTITY(1,1) NOT NULL,

	palabra NVARCHAR(100) NOT NULL,

	CONSTRAINT PK_PalabraClave PRIMARY KEY (id_palabra_clave)
);
