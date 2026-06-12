CREATE TABLE Ejemplar (
	num_ejemplar INT NOT NULL,   -- número físico del ejemplar dentro de su edición (1, 2, 3, ... reinicia por cod_isbn)

	cod_isbn CHAR(13) NOT NULL,

	id_estado INT NOT NULL,
	disponible BIT NOT NULL DEFAULT 1,   -- 1 = disponible para préstamo, 0 = ocupado

	CONSTRAINT PK_Ejemplar PRIMARY KEY (num_ejemplar, cod_isbn),

	CONSTRAINT FK_Ejemplar_Estado FOREIGN KEY (id_estado) REFERENCES Estado(id_estado),

	CONSTRAINT FK_Ejemplar_Edicion FOREIGN KEY (cod_isbn) REFERENCES Edicion(cod_isbn)
);
