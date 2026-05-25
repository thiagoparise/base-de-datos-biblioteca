CREATE TABLE DocenteMateria (
	numLector INT NOT NULL,
	idMateria INT NOT NULL,

	CONSTRAINT PK_DocenteMateria PRIMARY KEY (numLector, idMateria),

	CONSTRAINT FK_DocenteMateria_LectorDocente FOREIGN KEY (numLector) REFERENCES LectorDocente(numLector),

	CONSTRAINT FK_DocenteMateria_Materia FOREIGN KEY (idMateria) REFERENCES Materia(idMateria)
);