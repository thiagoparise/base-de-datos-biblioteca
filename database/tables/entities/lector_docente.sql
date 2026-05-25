CREATE TABLE LectorDocente (
	numLector INT NOT NULL,

	CONSTRAINT PK_LectorDocente PRIMARY KEY (numLector),

	CONSTRAINT FK_LectorDocente_Lector FOREIGN KEY (numLector) REFERENCES Lector(numLector)
);