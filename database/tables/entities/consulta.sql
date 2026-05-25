CREATE TABLE Consulta (
	idConsulta INT IDENTITY(1,1) NOT NULL,

	fechaConsulta DATE NOT NULL,

	codISBN CHAR(13) NOT NULL,
	numEjemplar INT NOT NULL,
	numLector INT NOT NULL,

	CONSTRAINT PK_Consulta PRIMARY KEY (idConsulta),

	CONSTRAINT FK_Consulta_Ejemplar FOREIGN KEY (numEjemplar, codISBN) REFERENCES Ejemplar(numEjemplar, codISBN),

	CONSTRAINT FK_Consulta_Lector FOREIGN KEY (numLector) REFERENCES Lector(numLector)
);