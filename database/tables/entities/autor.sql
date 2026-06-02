CREATE TABLE Autor (
	id_autor INT IDENTITY(1,1) NOT NULL,

	nombre NVARCHAR(100) NOT NULL,
	apellido NVARCHAR(100) NOT NULL,
	nombre_fantasia NVARCHAR(100) NOT NULL,
	fecha_nacimiento DATE NOT NULL,
	biografia NVARCHAR(MAX) NOT NULL,

	CONSTRAINT PK_Autor PRIMARY KEY (id_autor)
)
