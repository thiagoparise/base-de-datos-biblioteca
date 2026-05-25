CREATE TABLE LibroMateria (
	idLibro INT NOT NULL,
	idMateria INT NOT NULL,

	esObligatorio BIT NOT NULL,

	CONSTRAINT PK_LibroMateria PRIMARY KEY (idLibro, idMateria),

	CONSTRAINT FK_LibroMateria_Libro FOREIGN KEY (idLibro) REFERENCES Libro(idLibro),

	CONSTRAINT FK_LibroMateria_Materia FOREIGN KEY (idMateria) REFERENCES Materia(idMateria)
);