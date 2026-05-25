CREATE TABLE Prestamo (
	idPrestamo INT IDENTITY(1,1) NOT NULL,

	numLector INT NOT NULL,

	fechaRealizado DATE NOT NULL,

	CONSTRAINT PK_Prestamo PRIMARY KEY (idPrestamo),
	CONSTRAINT FK_Prestamo_Lector FOREIGN KEY (numLector) REFERENCES Lector(numLector)
);