CREATE TABLE Materia (
	id_materia INT IDENTITY(1,1) NOT NULL,

	nombre_materia NVARCHAR(100) NOT NULL,

	CONSTRAINT PK_Materia PRIMARY KEY (id_materia)
);
