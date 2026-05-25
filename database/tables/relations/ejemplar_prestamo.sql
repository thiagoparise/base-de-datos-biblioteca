CREATE TABLE EjemplarPrestamo (
	idPrestamo INT NOT NULL,
	codISBN CHAR(13) NOT NULL,
	numEjemplar INT NOT NULL, 

	idEstadoDevuelto INT,
	fechaDevuelto DATE,

	CONSTRAINT PK_EjemplarPrestamo PRIMARY KEY (idPrestamo, numEjemplar, codISBN),

	CONSTRAINT FK_EjemplarPrestamo_Prestamo FOREIGN KEY (idPrestamo) REFERENCES Prestamo(idPrestamo),

	CONSTRAINT FK_EjemplarPrestamo_Ejemplar FOREIGN KEY (numEjemplar, codISBN) REFERENCES Ejemplar (numEjemplar, codISBN),
	
	CONSTRAINT FK_EjemplarPrestamo_Estado FOREIGN KEY (idEstadoDevuelto) REFERENCES Estado(idEstado),
);