CREATE TABLE LectorGraduado (
	numLector INT NOT NULL,

	fechaEgreso DATE NOT NULL,

	CONSTRAINT PK_LectorGraduado PRIMARY KEY (numLector),

	CONSTRAINT FK_LectorGraduado_Lector FOREIGN KEY (numLector) REFERENCES Lector(numLector)
);