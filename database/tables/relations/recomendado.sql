CREATE TABLE Recomendado (
	numLector INT NOT NULL,
	idMateria INT NOT NULL,
	idLibro INT NOT NULL,

	CONSTRAINT PK_Recomendado PRIMARY KEY (numLector, idMateria, idLibro),

	CONSTRAINT FK_Recomendado_DocenteMateria FOREIGN KEY (numLector, idMateria) REFERENCES DocenteMateria(numLector, idMateria),

	CONSTRAINT FK_Recomendado_Libro FOREIGN KEY (idLibro) REFERENCES Libro(idLibro)
);