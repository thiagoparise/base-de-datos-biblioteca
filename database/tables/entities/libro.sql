CREATE TABLE Libro (
	idLibro INT IDENTITY(1,1) NOT NULL,

	titulo NVARCHAR(100) NOT NULL,

	idEditorial INT NOT NULL,
	idIdioma INT NOT NULL,

	CONSTRAINT PK_Libro PRIMARY KEY (idLibro),

	CONSTRAINT FK_Libro_Editorial FOREIGN KEY (idEditorial) REFERENCES Editorial(idEditorial),

	CONSTRAINT FK_Libro_Idioma FOREIGN KEY (idIdioma) REFERENCES Idioma(idIdioma)
);