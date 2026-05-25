CREATE TABLE Ejemplar (
	numEjemplar INT IDENTITY(1,1),

	codISBN CHAR(13) NOT NULL,

	idEstado INT NOT NULL,

	CONSTRAINT PK_Ejemplar PRIMARY KEY (numEjemplar, codISBN), -- Analizar si la PK podría ser unicamente numEjemplar 

	CONSTRAINT FK_Ejemplar_Estado FOREIGN KEY (idEstado) REFERENCES Estado(idEstado),

	CONSTRAINT FK_Ejemplar_Edicion FOREIGN KEY (codISBN) REFERENCES Edicion(codISBN)
);