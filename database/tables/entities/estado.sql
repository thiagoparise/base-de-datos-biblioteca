CREATE TABLE Estado (
	id_estado INT IDENTITY(1,1) NOT NULL,

	descripcion_estado NVARCHAR(100) NOT NULL,

	CONSTRAINT PK_Estado PRIMARY KEY (id_estado)
);
