CREATE TABLE Editorial (
	id_editorial INT IDENTITY(1,1) NOT NULL,

	nombre_editorial NVARCHAR(100) NOT NULL,

	CONSTRAINT PK_Editorial PRIMARY KEY (id_editorial)
);
