CREATE TABLE Libro (
	id_libro INT IDENTITY(1,1) NOT NULL,

	titulo NVARCHAR(100) NOT NULL,

	id_editorial INT NOT NULL,
	id_idioma INT NOT NULL,

	CONSTRAINT PK_Libro PRIMARY KEY (id_libro),

	CONSTRAINT FK_Libro_Editorial FOREIGN KEY (id_editorial) REFERENCES Editorial(id_editorial),

	CONSTRAINT FK_Libro_Idioma FOREIGN KEY (id_idioma) REFERENCES Idioma(id_idioma)
);
