CREATE TABLE Ejemplar (
	num_ejemplar INT IDENTITY(1,1),

	cod_isbn CHAR(13) NOT NULL,

	id_estado INT NOT NULL,

	CONSTRAINT PK_Ejemplar PRIMARY KEY (num_ejemplar, cod_isbn),

	CONSTRAINT FK_Ejemplar_Estado FOREIGN KEY (id_estado) REFERENCES Estado(id_estado),

	CONSTRAINT FK_Ejemplar_Edicion FOREIGN KEY (cod_isbn) REFERENCES Edicion(cod_isbn)
);
